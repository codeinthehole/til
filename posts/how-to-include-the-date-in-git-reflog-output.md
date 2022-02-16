---
title: "How to include the date in `git reflog` output"
date: "2021-03-25T17:11:34+00:00"
tags: ["Git"]
---

By default, the output of `git reflog` doesn't include the date when the
reference was updated. But `git reflog [show]` is an alias of `git log
--walk-reflogs --oneline` and so accepts any of the options of `git log`. This
means the date can be included by using the `--format` option.

Here's a fancy version:

```bash
git reflog --format="%C(yellow)%h%C(reset) %gs %C(green)%ad%C(reset) %C(blue)[%ar]%C(reset)"
```

which looks like:

{{< figure src="/images/git-reflog-with-date.png" title="" caption="" alt="git reflog with date" >}}
