---
title: "How Django's management commands need to be type hinted"
date: "2021-07-22T17:31:28+01:00"
tags: ["Django", "Mypy", "Python"]
---

For Django management commands with arguments, you might not expect Mypy
(configured with the [`django-stubs`](https://github.com/typeddjango/django-stubs) plugin) to
complain about this signature:

```py
from django.core.management.base import BaseCommand, CommandParser

class Command(BaseCommand):

    def add_arguments(self, parser: CommandParser) -> None:
        parser.add_argument("name")

    def handle(self, name: str, *args, **options) -> None:
        ...
```

but it does with error:

```
Signature of "handle" incompatible with supertype "BaseCommand" [override]
```

The problem is the `name` positional argument which makes the argument types
_more specific_ than `BaseCommand.handle` which has [type signature](https://github.com/typeddjango/django-stubs/blob/d5e45db79bcea6d6f4f45eacca3a2fe6e125e2e3/django-stubs/core/management/base.pyi#L70) :

```py
def handle(self, *args: Any, **options: Any) -> Optional[str]:
```

This is well explained in the [Mypy docs](https://mypy.readthedocs.io/en/stable/common_issues.html#incompatible-overrides):

> It's unsafe to override a method with a more specific argument type, as it
> violates the Liskov substitution principle. For return types, it’s unsafe to
> override a method with a more general return type.

To proceed you can either pluck the positional arguments out of the `kwargs`
dict:

```py
from django.core.management.base import BaseCommand, CommandParser

class Command(BaseCommand):

    def add_arguments(self, parser: CommandParser) -> None:
        parser.add_argument("name")

    def handle(self, *args, **options) -> None:
        name: str = options["name"]
        ...
```

or ignore the `override` error:

```py
from django.core.management.base import BaseCommand

class Command(BaseCommand):

    def add_arguments(self, parser: CommandParser) -> None:
        parser.add_argument("name")

    def handle(self, name: str, *args, **options) -> None:  # type: ignore[override]
        ...
```

The former is slightly safer as the ignore approach may cause issues if the type
signature of `BaseCommand.handle` changes in a future Django version.

Accurate as of Django v3.1, Django-Stubs v1.8 and Mypy v0.812.
