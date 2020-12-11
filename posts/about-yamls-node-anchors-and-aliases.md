---
title: "About YAML's node anchors and aliases"
date: "2020-12-11T20:53:22+00:00"
tags: ["YAML"]
---

I've seen these a few times but only today decided to actually work out how they
worked.

YAML lets you define an anchor (`&name`) for a node, sequence or scalar that you can refer
to later with an alias (`*name`). This lets you avoid duplication by extending or
overriding objects

```yaml
twin1: &person
    first: Barry
    last: Chuckle
twin2:
    <<: *person
    first: Paul
```

For more, see http://blogs.perl.org/users/tinita/2019/05/reusing-data-with-yaml-anchors-aliases-and-merge-keys.html



