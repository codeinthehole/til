---
title: "You can stack `pytest`'s `parametrize` decorators"
date: "2020-12-16T10:41:26+00:00"
tags: ["Python", "Testing", "Pytest"]
---

As in:

```py
import pytest

@pytest.mark.parametrize("x", [1,2,3])
@pytest.mark.parametrize("y", [4,5,6])
def test_cartesian_product(x, y):
    pass
```

which will run the test for all combinations of the two input lists:

```text
test_parameterize.py::test_cartesian_product[4-1] PASSED
test_parameterize.py::test_cartesian_product[4-2] PASSED
test_parameterize.py::test_cartesian_product[4-3] PASSED
test_parameterize.py::test_cartesian_product[5-1] PASSED
test_parameterize.py::test_cartesian_product[5-2] PASSED
test_parameterize.py::test_cartesian_product[5-3] PASSED
test_parameterize.py::test_cartesian_product[6-1] PASSED
test_parameterize.py::test_cartesian_product[6-2] PASSED
test_parameterize.py::test_cartesian_product[6-3] PASSED
```

See <https://docs.pytest.org/en/stable/parametrize.html>
