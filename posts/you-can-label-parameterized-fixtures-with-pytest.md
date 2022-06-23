---
title: "You can label parameterized fixtures with pytest"
date: "2020-12-11T13:28:09+00:00"
tags: ["Testing", "Python", "Pytest"]
---

For example, running this parameterized test:

```py
@pytest.mark.parametrize(
    "date",
    (
        datetime.date(2012, 12, 21),  # Predicted by Mayans
        datetime.date(1988, 3, 25),  # Predicted by True Way
    ),
)
def test_did_world_did_not_end_on(date):
    pass
```

in verbose mode gives output:

```txt
$ pytest -v test_predictions.py
============== test session starts ==============
...
test_predictions.py::test_did_world_did_not_end_on[date0] PASSED
test_predictions.py::test_did_world_did_not_end_on[date1] PASSED
```

As you can see, the tests are distinguished by the labels `date0` and `date1` —
not that informative.

We can do better by using the `ids` kwarg to `pytest.mark.parametrize` to
provide more useful labels.

```py
@pytest.mark.parametrize(
    "date",
    (
        datetime.date(2012, 12, 21),
        datetime.date(1988, 3, 25),
    ),
    ids=("date predicted by Mayans", "date predicted by True Way"),
)
def test_world_did_not_end_on(date):
    pass
```

which leads to:

```txt
$ pytest -v test_predictions.py
============== test session starts ==============
...
test_predictions.py::test_world_did_not_end_on[date predicted by Mayans] PASSED
test_predictions.py::test_world_did_not_end_on[date predicted by True Way] PASSED
```

See
<https://docs.pytest.org/en/stable/reference.html#pytest.python.Metafunc.parametrize>
