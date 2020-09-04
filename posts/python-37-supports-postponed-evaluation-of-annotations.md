---
title: "Python 3.7 supports postponed evaluation of annotations"
date: "2020-09-04T16:27:33+01:00"
tags: ["Python"]
---

For example, instead of:

```py
import _csv

def generate_report(writer: '_csv._writer'):
    pass
```

you can use:

```py
from __future__ import annotations

import _csv

def generate_report(writer: _csv._writer):
    pass
```

and avoid using a string literal for the type annotation.

This follows on from a [related TIL about how to specify type annotations for the `csv` module]({{< ref "posts/how-to-typecheck-csv-objects-in-python" >}}).

Related:

- [`__future__` statement definitions](https://docs.python.org/3/library/__future__.html)
- [PEP 563 - Postponed Evaluation of Annotations](https://www.python.org/dev/peps/pep-0563/)
