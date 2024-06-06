---
title: "How to create a wrapping mock with custom behaviour"
date: "2024-06-05T20:11:52+01:00"
tags: ["Testing", "Python"]
summary: "You can use the `mock.DEFAULT` sentinel value."
---

Python's `unittest.mock` package lets you create wrapper mocks that forward on
calls to the original object. This is done using the `wraps` parameter - e.g.

```py
from unittest import mock

class Order:
    @staticmethod
    def get_value():
        return 42

def test_method_calls_are_forwarded_on():
    # Create a wrapping mock that forwards calls to the original `Order` class.
    spy = mock.Mock(spec=Order, wraps=Order)

    # Calling `get_value` will be forwarded on.
    assert spy.get_value() == 42

    # We can verify how the object was called afterwards.
    spy.get_value.assert_called_once()
```

Such test doubles are commonly known as spies.

It's possible to intercept wrapped calls to run some custom code before
forwarding on to the wrapped object. This is done by assigning a new callable to
the `side_effect` attribute of the method that returns the sentinel value
`mock.DEFAULT`:

```py
from unittest import mock

class Order:
    @staticmethod
    def get_value():
        return 42

def test_intercepted_method_calls():
    # Create a wrapping mock that forwards calls to the original `Order` class.
    spy = mock.Mock(spec=Order, wraps=Order)

    # Create a variable that the wrapper can mutate. This is just to verify the
    # interception is working.
    calls = []

    # Define a wrapper function that does something simple then returns the
    # sentinel value.
    def _wrap_get_value():
        calls.append("Wrapper function called")
        return mock.DEFAULT

    # Assign the wrapper function to the `get_value` method.
    spy.get_value.side_effect = _wrap_get_value

    # Since the wrapper returns `mock.DEFAULT`, the call will be forwarded on
    # and so the return value should still be 42.
    assert spy.get_value() == 42

    # Verify that the wrapper function was called.
    assert calls == ["Wrapper function called"]
```

This is quite niche, but we've been using it recently to ensure some function
calls fail during the collection phase of running a test suites. In this case
the wrapper function is something like:

```py
def _wrapper():
    if session._in_collection_phase::
        raise RuntimeError("This function not be called during test collection.")
    return mock.DEFAULT
```

This behaviour is documented in the [order of precedence][precedence] section of
the `unittest.mock` documentation.

[precedence]:
  https://docs.python.org/3/library/unittest.mock.html#order-of-precedence-of-side-effect-return-value-and-wraps
