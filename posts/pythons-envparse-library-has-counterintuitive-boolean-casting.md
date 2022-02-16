---
title: "Python's `envparse` library has counter-intuitive boolean casting"
date: "2021-10-14T14:14:59+01:00"
tags: ["Python"]
---

If you use `env.bool` from the [`envparse`](https://github.com/rconradharris/envparse) library to convert an
environment variable into a boolean Python variable then only an allow-list of strings are considered truthy.

For example:

```sh
$ pip install envparse
$ X=0 python -c "from envparse import env; print(env.bool('X'))"
False
$ X=1 python -c "from envparse import env; print(env.bool('X'))"
True
$ X=2 python -c "from envparse import env; print(env.bool('X'))"
False
$ X=true python -c "from envparse import env; print(env.bool('X'))"
True
$ X=truthy python -c "from envparse import env; print(env.bool('X'))"
False
$ X="in Python this would cast to True" python -c "from envparse import env; print(env.bool('X'))"
False
```

The [allow-list is](https://github.com/rconradharris/envparse/blob/e67e70307af19d925e194b2a163e0608dae7eb55/envparse.py#L54):

```py
BOOLEAN_TRUE_STRINGS = ('true', 'on', 'ok', 'y', 'yes', '1')
```

Since this differs from how Python casts strings to booleans, it is somewhat
surprising.
