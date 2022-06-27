---
title: "How to override Django's settings for every method in a test class"
date: "2022-06-27T18:55:54+01:00"
tags: ["Pytest", "Django", "Testing"]
---

Django's [`override_settings` decorator][override_settings] only works on
functions and methods in [subclasses of `unittest.TestCase`][subclass].

But it's common to group tests in plain Python classes when using Pytest, which
means `override_settings` can't be used to decorate a class and override
settings for every test method.

Instead, do this with an `autouse=True` fixture and the [`settings`
fixture][settings_fixture] provided by the [`pytest-django`][pytest_django]
package.

For example:

```py
import pytest
from django.conf import settings as django_settings

class TestAutouseFixture:
    @pytest.fixture(autouse=True)
    def configure_settings(self, settings):
        # The `settings` argument is a fixture provided by pytest-django.
        settings.FOO = "bar"

    def test_one(self):
        assert django_settings.FOO == "bar"

    def test_two(self):
        assert django_settings.FOO == "bar"
```

<br/>

---

🤦‍♂️ Oops — turns out I learnt this
[last year too](/posts/you-can-have-classscoped-autouse-pytest-fixtures/),
although my example then used `override_settings` as a context manager.

[override_settings]:
  https://docs.djangoproject.com/en/4.0/topics/testing/tools/#django.test.override_settings
[subclass]:
  https://github.com/django/django/blob/b2eff16806057095c7dd3daa9402ad615e51627f/django/test/utils.py#L440
[settings_fixture]:
  https://pytest-django.readthedocs.io/en/latest/helpers.html#settings
[pytest_django]: https://pytest-django.readthedocs.io/en/latest/index.html
