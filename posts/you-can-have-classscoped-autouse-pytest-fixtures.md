---
title: "You can have class-scoped autouse pytest fixtures"
date: "2021-03-16T17:36:21+00:00"
tags: ["pytest", "Python", "Testing"]
---

If you decorate a class instance method as an `autouse=True` Pytest fixture,
then it will be automatically applied for all test methods on that class. This
is a useful pattern to remember.

For example, it can be employed to apply the same context management for all
tests in the class. For example, if you wanted to patch Django's settings for
all test methods:

```py
import pytest
from django.test import override_settings
from django.conf import settings


class TestSomethingAboutTimezones:

    @pytest.fixture(autouse=True)
    def use_london_timezone(self):
        with override_settings(TIME_ZONE="Europe/London"):
            yield

    def test_something(self):
        # This will pass.
        assert settings.TIME_ZONE == "Europe/London"

    def test_something_else(self):
        # This will pass.
        assert settings.TIME_ZONE == "Europe/London"
```

You probably wouldn't use it for mocking since the `mock.patch` decorators
already work on classes but there are use-cases where it would be helpful.

Docs on the `autouse` option:
<https://docs.pytest.org/en/stable/fixture.html#autouse-fixtures-fixtures-you-don-t-have-to-request>
