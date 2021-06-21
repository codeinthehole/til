---
title: "About `mypy`'s unreachable code functionality"
date: "2021-06-21T14:54:25+01:00"
tags: ["mypy", "Python"]
---

Mypy [can be configured](https://mypy.readthedocs.io/en/stable/common_issues.html#unreachable-code) to raise an error when it finds unreachable code.
This is a useful check and can highlight several categories of bug.

To enable, ensure your `setup.cfg` includes:

```ini
[mypy]
warn_unreachable = true
```

Further reading:

- [Python Type Hints - How to use Mypy’s unreachable code detection](https://adamj.eu/tech/2021/05/19/python-type-hints-mypy-unreachable-code-detection/)


