---
title: "About `git-absorb`"
date: "2021-03-28T11:28:17+01:00"
tags: ["Git"]
---

[`git-absorb`](https://github.com/tummychow/git-absorb) is a great tool for crafting atomic commits. Given some uncommitted
changes, it automates the process of identifying which commit to squash each
change into. The workflow is simply:

```bash
$ vim  # address code-review feedback
$ git add $CHANGED_FILES
$ git absorb --and-rebase
```

There's an excellent [elevator pitch](https://github.com/tummychow/git-absorb#elevator-pitch) on
the project README.

Highly recommended.


