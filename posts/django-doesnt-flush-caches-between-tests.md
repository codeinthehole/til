---
title: "Django doesn't flush caches between tests"
date: "2021-07-23T15:03:26+01:00"
tags: ["Django", "Testing", "Python"]
---

This is slightly counter-intuitive as it's different to how databases are
treated by the test runner. It is noted
[in the docs](https://docs.djangoproject.com/en/3.2/topics/testing/overview/#other-test-conditions)
and there's an [open ticket](https://code.djangoproject.com/ticket/11505) on the
matter.

To work around, here's a Pytest fixture that flushes the cache after a test:

```py
from django.conf import settings
from django.core.cache import cache
import pytest

@pytest.fixture
def reset_cache():
    yield

    assert settings.CACHES["default"]["BACKEND"] == "django.core.cache.backends.locmem.LocMemCache"
    cache.clear()
```
