---
title: "How to count lines of code in a Git repo for a given commit"
date: "2020-09-17T15:54:21+01:00"
tags: ["Git"]
---

For a given commit `$SHA`, use:

```sh
git diff --shortstat `git hash-object -t tree /dev/null`..$SHA
```

which works as `git hash-object -t tree /dev/null` computes the hash of the
empty tree.
