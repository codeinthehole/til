---
title:
  "How the `new` argument to `mock.patch` is shared between parameterized tests"
date: "2022-11-08T18:16:53+00:00"
tags: ["Pytest", "Testing"]
---

Consider this contrived test:

```py
from unittest import mock
import pytest

def get_config():
    """Return a config object with a 'salutation' attribute."""
    pass

def say_hello(name):
    """Return a greeting."""
    return get_config().salutation + " " + name

@mock.patch(
    __name__ + ".get_config",
    new=mock.Mock(return_value=mock.Mock(salutation="Hello"))
)
@pytest.mark.parametrize("name", ("Alan", "Barry", "Calum"))
def test_say_hello(name):
    assert say_hello(name) == f"Hello {name}"
```

We are testing the `say_hello` function three times with different arguments and
use `mock.patch` to stub the response of the `get_config` function, passing in
the replacement version _at compile/collection time_ using the `new` parameter.

All three tests pass:

```txt
test_patch_state.py::test_say_hello[Alan] PASSED
test_patch_state.py::test_say_hello[Barry] PASSED
test_patch_state.py::test_say_hello[Calum] PASSED
```

## Test pollution via shared state

But there is potential test pollution as the same `mock.Mock` instance is used
to replace the `get_config` function in each parameterised test.

To see this, consider mutating the `get_config` mock in the test body:

```py
@mock.patch(
    __name__ + ".get_config", new=mock.Mock(return_value=mock.Mock(salutation="Hello"))
)
@pytest.mark.parametrize("name", ("Alan", "Barry", "Calum"))
def test_say_hello(name):
    assert say_hello(name) == f"Hello {name}"

    # Mutate the `get_config` return value.
    get_config.return_value.salutation = "Hi"
```

Now we see two failures:

```
test_patch_state.py::test_say_hello_1[Alan] PASSED
test_patch_state.py::test_say_hello_1[Barry] FAILED
test_patch_state.py::test_say_hello_1[Calum] FAILED

...
E AssertionError: assert 'Hi Barry' == 'Hello Barry'

...
E AssertionError: assert 'Hi Calum' == 'Hello Calum'
```

The latter two tests fail as the change to the return value of `get_config` in
the first test pollutes the second and third tests.

This is a potential cause of flakey tests.
