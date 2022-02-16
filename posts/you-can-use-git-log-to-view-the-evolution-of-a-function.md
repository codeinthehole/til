---
title: "You can use Git log to view the evolution of a function"
date: "2021-03-05T22:49:17+00:00"
tags: ["Git"]
---

Modern versions of `git log` provide a `-L` option which lets you trace the
evolution of a line range or function:

{{< figure src="/images/git-log-function-evolution.png" title="" caption="" alt="git log function evolution" >}}

Usage is:

```bash
git log -L :<funcname>:<file>
```

where:

- `<funcname>` is a regular expression to match the function name.
- `<file>` is the path to the file where the function lives.

Example usage:

```bash
git log -L :get_locale:octoenergy/utils/workingdays.py
```

Depending on what language you're working with, you may need to adjust you local
`~/.gitattributes` file to ensure Git can determine the patch hunk headers.

More in
[the official git docs](https://git-scm.com/docs/git-log/#Documentation/git-log.txt--Lltfuncnamegtltfilegt).
