---
title: "A better way of configuring `mypy`"
date: "2020-12-10T15:51:44+00:00"
tags: ["Python", "mypy"]
---

I didn't realise you can put _all_ your config into `setup.cfg` so that you can
just run:

```bash
$ mypy
```

with (no further options) to run the type checker.

A typical `setup.cfg` contains this kind of thing:

```dosini
[mypy]
show_error_codes = True
warn_unused_ignores = True
files = .

[mypy-pytest]
ignore_missing_imports = True

[mypy-structlog]
ignore_missing_imports = True
```



