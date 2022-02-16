---
title: "How to find the files from a commit that deleted a given pattern"
date: "2021-10-15T16:54:35+01:00"
tags: ["Git"]
---

The [`--name-only`](https://git-scm.com/docs/git-show#Documentation/git-show.txt---name-only) option for `git log`
restricts the output to the changed file paths but not their full diffs.
However, by default, the output still includes the commit
subject and description which means the output can't be piped into commands that
expect a list of file paths.

To strip out everything except the changed paths, use:

```sh
git log --name-only --pretty=format:
```

Which is useful enough to warrant an alias in `~/.gitconfig`:

```ini
[alias]
filepaths = show --name-only --pretty=format:
```

Then you can do things like find all the files changed in a commit that contain
a given pattern:

```sh
git filepaths | xargs rg -l "$QUERY"
```

Further, if you want to find all the changed files where a given pattern was
_removed_ in a commit, you can use the [`-S`](https://git-scm.com/docs/git-show#Documentation/git-show.txt--Sltstringgt)
option of `git log` to search the added and removed lines for a pattern:

```sh
git filepaths -S "$QUERY"
```

Which we can pipe to Vim so we can edit the identified files:

```sh
git filepaths -S "$QUERY" | xargs -o vim
```

You could also do this without leaving Vim by loading the files into the
argument list:

```vim
:args `git filepaths -S "$QUERY"`
```

See my post on [Vim's lists](https://codeinthehole.com/tips/vim-lists/) if
you're into this kind of thing.
