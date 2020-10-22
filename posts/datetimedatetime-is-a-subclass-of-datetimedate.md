---
title: "`datetime.datetime` is a subclass of `datetime.date`"
date: "2020-10-22T15:38:04+01:00"
tags: ["Python"]
---

See for yourself:

```py
>>> import datetime
>>> isinstance(datetime.datetime.now(), datetime.date)
True
```

Apparently, [this is not a bug](https://bugs.python.org/issue28878) but it is
certainly confusing.

