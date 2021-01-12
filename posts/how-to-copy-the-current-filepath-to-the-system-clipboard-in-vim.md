---
title: "How to copy the current filepath to the system clipboard in Vim"
date: "2021-01-12T11:52:56+00:00"
tags: ["Vim"]
---

Run:

```vim
:let @* = expand("%")
```

where `@*` references the system clipboard register.

