---
title: "YAML has several string-parsing gotchas"
date: "2020-09-21T12:33:56+01:00"
tags: ["YAML", "Gotchas"]
---

For instance, in YAML 1.1:

- `Yes` and `No` parse to `true` and `false`
- `x:y` is parsed as a base-60 number if `y` is less than 60

See for yourself with these Python tests:

```py
import yaml
import io


def test_parsing_iso_country_codes():
    f = io.StringIO("""---
england: GB
norway: NO
""")
    content = yaml.load(f, Loader=yaml.FullLoader)

    assert content == {
        "england": "GB",
        "norway": False,
    }


def test_parsing_ports():
    f = io.StringIO("""---
low: 1:1
high: 20:100
""")
    content = yaml.load(f, Loader=yaml.FullLoader)

    assert content == {
        "low": 61,  # which is '1:1' in base-60
        "high": "20:100"
    }
```

Related:

- [YAML 1.1 spec](https://yaml.org/type/float.html)
