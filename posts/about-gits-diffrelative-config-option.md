---
title: "About Git's `diff.relative` config option"
date: "2021-10-12T14:37:13+01:00"
tags: ["Git"]
---

Setting this option to true in `~/.gitconfig` ensures diff commands show paths
relative to the current directory:

```ini
[diff]
relative = true
```

This is mentioned on the
[diff options](https://git-scm.com/docs/diff-options#Documentation/diff-options.txt---relativeltpathgt)
page in the Git online manual.
