---
title: "About `mypy`'s `reveal_type` and `reveal_locals` functions"
date: "2021-06-16T17:33:21+01:00"
tags: ["Python", "mypy"]
---

Which can be used for debugging type annotation problems. Insert them liberally
into your code before running `mypy` to see the inferred static types of
expressions or local variables.

Make sure you remove them before committing or the Python interpreter will
complain.

More at
[displaying the type of an expression](https://mypy.readthedocs.io/en/latest/common_issues.html?highlight=reveal_type#reveal-type)
in the `mypy` docs.
