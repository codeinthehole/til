---
title:
  "That FreezeGun doesn't work with Pytest fixtures (unless you use
  `pytest-freezegun`)"
date: "2021-07-12T17:05:19+01:00"
tags: ["Python", "Testing"]
---

Wrapping tests classes with
[FreezeGun](https://github.com/spulec/freezegun#decorator)'s
`@freezegun.freeze_time` doesn't control calls to the system clock from
fixtures. That is, this test fails when run on any date other than 2021-07-01:

```py
import datetime
import freezegun
import pytest

@pytest.fixture()
def current_date():
    return datetime.date.today()

@freezegun.freeze_time("2021-07-01")
def test_freezing_with_library_freezegun(current_date):
    today = datetime.date.today()
    assert today == current_date
```

with result:

```txt
test_freezegun_example.py:12: in test_freezing_with_library_freezegun
    assert today == today_from_fixture
E   assert FakeDate(2021, 7, 1) == datetime.date(2021, 7, 12)
E     +FakeDate(2021, 7, 1)
E     -datetime.date(2021, 7, 12)
```

However, if you use the `pytest.mark.freeze_time` decorator provided by
[`pytest-freezegun`](https://github.com/ktosiek/pytest-freezegun), then calls to
the system clock in the fixture function _are_ controlled by FreezeGun.

For example, if we replace `@freezegun.freeze_time` with
`@pytest.mark.freeze_time` then the test always passes no matter what day it is
run:

```py
import datetime
import freezegun
import pytest

@pytest.fixture()
def current_date():
    return datetime.date.today()

@pytest.mark.freeze_time("2021-07-01")
def test_freezing_with_pytest_freezegun(current_date):
    today = datetime.date.today()
    assert today == current_date
```
