---
title: "Some Markdown parsers support definition lists"
date: "2022-06-01T10:24:44+01:00"
tags: ["Markdown"]
---

Parsers like [goldmark](https://github.com/yuin/goldmark/) (the default parser
for Hugo) support definition lists.

Example syntax:

<!-- prettier-ignore -->
```md
Apple
:   Pomaceous fruit of plants of the genus Malus in 
    the family Rosaceae.

Orange
:   The fruit of an evergreen tree of the genus Citrus.
```

which renders as:

<!-- prettier-ignore -->
Apple
:   Pomaceous fruit of plants of the genus Malus in
    the family Rosaceae.

<!-- prettier-ignore -->
Orange
:   The fruit of an evergreen tree of the genus Citrus.

This isn't supported by Github flavoured Markdown yet.
