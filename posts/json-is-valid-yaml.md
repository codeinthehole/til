---
title: "JSON is valid YAML"
date: "2021-03-26T14:37:33+00:00"
tags: ["YAML", "JSON"]
---

YAML is a superset of JSON which means a YAML parser can parse JSON (but not
necessarily the other way around).

This test passes:

```py
import io
import json
import yaml

def test_json_is_yaml():
    data = {"name": "Jimmy", "attributes": {"age": 35, "height": 1.89}}
    f = io.StringIO(json.dumps(data))
    from_json = yaml.load(f, Loader=yaml.FullLoader)

    f = io.StringIO(
        """---
name: Jimmy
attributes:
    age: 35
    height: 1.89
"""
    )
    from_yaml = yaml.load(f, Loader=yaml.FullLoader)

    assert from_json == from_yaml
```

This is noted in the [YAML spec](https://yaml.org/spec/1.2/spec.html#id2759572):

> Both JSON and YAML aim to be human readable data interchange formats. However,
> JSON and YAML have different priorities. JSON’s foremost design goal is
> simplicity and universality. Thus, JSON is trivial to generate and parse, at
> the cost of reduced human readability. It also uses a lowest common
> denominator information model, ensuring any JSON data can be easily processed
> by every modern programming environment.
>
> In contrast, YAML’s foremost design goals are human readability and support
> for serializing arbitrary native data structures. Thus, YAML allows for
> extremely readable files, but is more complex to generate and parse. In
> addition, YAML ventures beyond the lowest common denominator data types,
> requiring more complex processing when crossing between different programming
> environments.
>
> YAML can therefore be viewed as a natural superset of JSON, offering improved
> human readability and a more complete information model. This is also the case
> in practice; every JSON file is also a valid YAML file. This makes it easy to
> migrate from JSON to YAML if/when the additional features are required.


