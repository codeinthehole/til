---
title: "That `mypy` only type-checks functions that have at least one type annotation"
date: "2021-06-16T15:16:58+01:00"
tags: ["Python", "mypy"]
---

This is noted in the [common issues and solutions][mypy_docs] documentation. For
example `mypy` doesn't complain about this obviously wrong function call:

[mypy_docs]: https://mypy.readthedocs.io/en/stable/common_issues.html#no-errors-reported-for-obviously-wrong-code

```py
def cast_int_to_string(x: int) -> str:
    return f"{x}"

def main():
    cast_int_to_string("x")
```

but does if we annotate the return type of `main`:

```py
def cast_int_to_string(x: int) -> str:
    return f"{x}"

def main() -> None:
    cast_int_to_string("x")
```

Hence it's valuable to annotate `None` return types to ensure `mypy` type-checks
them.
