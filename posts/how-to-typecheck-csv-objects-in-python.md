---
title: "How to use type annotations with Python's `csv` module"
date: "2020-09-03T17:13:22+01:00"
tags: ["Python"]
---

Adding a type annotation for a "writer" object created by `csv.writer(...)` is fiddlier than you might think.

The type of the writer object is `_csv.writer` which you verify with:

```py
>>> import csv, sys
>>> type(csv.writer(sys.stdout))
<class '_csv.writer'>
```

but if you try this:

```py
import _csv

def generate_report(writer: _csv.writer):
    pass
```

`mypy` complains that:

```
Function "_csv.writer" is not valid as a type  [valid-type].
```

The correct approach is to use `_csv._writer` as the type annotation.  A string literal is required
otherwise you'll get a `AttributeError: module '_csv' has no attribute '_writer'` exception.

```py
import _csv

def generate_report(writer: '_csv._writer'):
    pass
```

