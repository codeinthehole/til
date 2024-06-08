---
title: "How to show the history of a file with `git log --patch`"
date: "2023-01-11T15:41:02+00:00"
tags: ["Git", "Vim"]
---

Am slightly embarrassed to admit it but I've only just discovered the `--patch`
option to `git log` which shows diff information for each commit.

## History of a file

It's particular useful for inspecting the history of a single file, showing the
the change that each commit made. For example, here's how to example the changes
to Django's `LICENSE` file over the years:

```sh
git log --patch --follow -- LICENSE
```

which reveals:

{{< figure src="/images/history-of-django-license-file.png" link="/images/history-of-django-license-file.png" title="" caption="" alt="History of Django LICENSE file" >}}

## Not possible in Github

There's no equivalent feature to this in Github's UI. While the "history" page
for a file shows the commits that have touched it, there's no easy way to see
the diff for that file in each commit.

## In Vim

This works nicely with `vim-fugitive`. Running `:Git log -p --follow %` opens
the history for the current file in a split with all of Fugitive's helpful
key-binds available for traversing the commits.

{{< figure src="/images/history-of-a-file-in-vim.png" link="/images/history-of-a-file-in-vim.png" title="" caption="" alt="History of a file in Vim" >}}
