---
title: "About indirect parametrization with Pytest"
date: "2022-08-24T14:24:35+01:00"
tags: ["Pytest", "Testing", "Python"]
---

Pytest's [`pytest.mark.parametrize`][pytest_parametrize] function supports an
[`indirect` argument][pytest_indirect] that allows a parametrized test to have
its parameter passed to a fixture function, rather than directly into the test
function.

[pytest_parametrize]: https://docs.pytest.org/en/7.1.x/example/parametrize.html
[pytest_indirect]:
  https://docs.pytest.org/en/7.1.x/example/parametrize.html#indirect-parametrization

This is useful for deferring expensive set-up to be executed at test runtime,
rather than at collection time.

To illustrate, here's an example of _direct_ parametrization where the value of
`x` is passed directly into the test function:

```py
import pytest

@pytest.mark.parametrize("x", (1,2,3))
def test_direct(x):
    assert x > 0
```

And here's an example of _indirect_ parametrization where the first argument to
`pytest.mark.parametrize` is the name of a fixture:

```py
import pytest

@pytest.fixture
def x(request):
    """
    Transform the value of "x" before it is passed to the test.
    """
    return request.param * 100

@pytest.mark.parametrize("x", (1,2,3), indirect=True)
def test_indirect(x):
    assert x > 100
```

In my opinion, it reads awkwardly as the fixture and the parameter need to share
the same name. Above, the fixture needs to be named `x` but it would be better
named `multiply` or something like that.

It's also possible to transform [only some of the arguments injected by
`pytest.mark.parametrize`][some_args].

[some_args]:
  https://docs.pytest.org/en/7.1.x/example/parametrize.html#apply-indirect-on-particular-arguments
