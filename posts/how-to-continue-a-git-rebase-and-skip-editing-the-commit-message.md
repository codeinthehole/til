---
title: "How to continue a Git rebase and skip editing the commit message"
date: "2021-11-12T11:37:54+00:00"
tags: ["Git"]
---

During an interactive rebase, when you've fixed the conflicts or finished editing the
commit you can run:

```sh
$ git rebase --continue
```

to continue rebasing. Before proceeding, this will open the commit message in your
configured editor so you can make any adjustments based on the changes you've made.

However, 90% of the time I don't want to edit the commit message as I'm just
fixing a minor issue and the existing commit message is still accurate. The
editor step is superfluous and a waste of time.

To skip the editor step entirely you can use:

```sh
$ GIT_EDITOR=true git rebase --continue
```

which replaces the editor program with `true` which simply exits with a zero
exit code.

Source: ["How to suppress the editor for `git rebase
--continue`?"](https://stackoverflow.com/questions/43489971/how-to-suppress-the-editor-for-git-rebase-continue)
on Stack Overflow.

