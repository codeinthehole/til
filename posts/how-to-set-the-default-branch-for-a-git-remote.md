---
title: "How to set the default branch for a Git remote"
date: "2024-05-10T21:59:31+01:00"
tags: ["Git"]
---

_Just putting this here as I always forget._

I have a Git alias for determining the default branch of a repo.

```dosini
defaultbranch = "!f() { git symbolic-ref refs/remotes/origin/HEAD | cut -d/ -f4; }; f"
```

It's used in other aliases and commands for things like creating pull requests.

Sometimes though, it errors when used in a newly cloned repository:

```sh
$ git defaultbranch
fatal: ref refs/remotes/origin/HEAD is not a symbolic ref
```

Here `origin/HEAD` is a symbolic ref that points to the default branch of the
`origin` remote. It's normally set automatically after cloning but this can fail
if your permissions don't allow write access for the repo (I think).

Easily fixed with:

```sh
git remote set-head origin --auto
```
