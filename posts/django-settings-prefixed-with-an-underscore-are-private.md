---
title: "Django settings prefixed with an underscore are private"
date: "2021-09-20T15:04:15+01:00"
tags: ["Django", "Python"]
---

As in: you can't access them from outside the settings module.

If you have:

```py
_FOO = 1
```

in your settings module, then this test:

```py
from django.conf import settings

def test_private_settings_are_inaccessible():
    assert settings._FOO == 1
```

will fail with error:

```text
AttributeError: 'Settings' object has no attribute '_FOO'
```
