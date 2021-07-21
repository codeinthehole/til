---
title: "File-level flake8 comments ignore all errors"
date: "2021-07-21T15:01:33+01:00"
tags: ["Flake8", "Python"]
---

Until today, I was under the impression that including:
```py
# flake8: noqa: F401
```
at the top of a Python module would ignore all F401 errors in the file.

However that isn't true: the above directive ignores _all_ errors in the file,
not just F401: the `: F401` part of the comment is silently ignored.

Alternatively you can:

- append `# noqa: F401` to each offending line, or:
- use the [`--per-file-ignores` configuration option](https://flake8.pycqa.org/en/latest/user/options.html#cmdoption-flake8-per-file-ignores) to ignore certain error
  codes in files matching a set of globs.

Related:

- [Flake8 docs on ignoring entire files](https://flake8.pycqa.org/en/3.1.1/user/ignoring-errors.html#ignoring-entire-files)

