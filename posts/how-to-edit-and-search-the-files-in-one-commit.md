---
title: "How to edit and search the files in one commit"
date: "2024-03-27T14:56:20+00:00"
tags: ["Git", "Vim"]
---

When interactive rebasing, it's useful to be able to edit all the files in one
particular commit. Here's how you can do that.

## Select a commit to edit

First, mark the commit you want to edit with an `e` in the `git-rebase-todo`
buffer that Git presents when you start an interactive rebase:

```text
e 68704c08a008 Make the change easy
pick a6d294d39d5e Make the easy change
```

## Opening the commit's files in Vim

Open the files changed in the `HEAD` commit (i.e. the one being edited):

```vim
:args `git commitfiles`
```

where `git commitfiles` is aliased as:

```conf
commitfiles = "!f() {
    cd ${GIT_PREFIX:-./};
    git diff --relative --name-only ${1:-HEAD}^ ${1:-HEAD};
}; f"
```

in `~/.gitconfig` (all on one line - line breaks here are for readability).

## Search the commit's files

You can search only the current buffers with this command:

```vim
:noautocmd bufdo vimgrepadd "foo" % | copen
```

This runs the `vimgrepadd` command on each buffer and appends results to the
quickfix list, which is opened at the end with `copen`. The `noautocmd` prefix
is a speed optimisation.

<!-- https://stackoverflow.com/questions/11975174/how-do-i-search-the-open-buffers-in-vim -->
