---
title: "How to pipe an argument list into Vim"
date: "2021-01-15T09:45:07+00:00"
tags: ["Vim", "ripgrep", "fd"]
---

Use something like:

```bash
echo file1 file2 | xargs -o vim
```

The `-o` option for `xargs` re-opens `stdin` as `/dev/tty` (rather than the
default `/dev/null`) and is essential otherwise Vim will [break your terminal
when it exits][xargs].

[xargs]:
  https://superuser.com/questions/336016/invoking-vi-through-find-xargs-breaks-my-terminal-why

This is a useful way of populating Vim's [argument list]. It works especially well
with modern search tools `fd` and `ripgrep`. For example:

```bash
$ rg --type py --files-with-matches "logger = .*getLogger*" \
    | xargs rg --files-without-match "logger\." \
    | xargs -o vim
```

This instructs Vim to open all Python files that create a `logger` instance but
don't actually use it.

[argument list]: https://vimhelp.org/editing.txt.html#argument-list
