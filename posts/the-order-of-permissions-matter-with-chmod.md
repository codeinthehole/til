---
title: "The order of permissions matters with `chmod`"
date: "2021-02-06T15:54:07+00:00"
tags: ["Unix"]
---

As in these two commands behave differently:

```bash
chmod -R g+X,g-wx .  # DOESN'T set group executable bit on folders
chmod -R g-wx,g+X .  # DOES set group executable bit on folders
```
