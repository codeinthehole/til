---
title: "You can arbitrarily chain Python comparison operations"
date: "2021-01-15T16:05:14+00:00"
tags: ["Python"]
---

Which explains why:

```python
>>> False == False in [False]
True
```

This odd looking expression is equivalent to `(False == False) and (False in
[False])`, hence why it evaluates to `True`.

And since there's no limit to how many comparisons can be chained together, this
kind of thing is legal syntax:

```python
>>> False is False == False in [False] in [[False]] not in [False]
True
```

See the [Python docs on comparisons for more details](https://docs.python.org/3/reference/expressions.html#comparisons).
