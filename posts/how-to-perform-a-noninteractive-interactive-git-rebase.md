---
title: "How to perform a non-interactive, interactive Git rebase"
date: "2023-02-15T14:49:51+00:00"
tags: ["Git"]
---

If you create a load of fix-up commits using:

```bash
git commit --fixup $COMMIT_HASH
```

then you don't necessarily want to run `git rebase` in interactive mode to fold
these commits into the branch history.

The `--autosquash` option is sufficient as it re-orders the rebase todo list to
squash the fix-up commits into their biological parents.

In such cases, opening and closing an editor is a waste of time.

Instead, use the `GIT_SEQUENCE_EDITOR` environment variable to specify a
non-interactive no-op "editor" like `true` (or even merely `:`). E.g.

```bash
GIT_SEQUENCE_EDITOR=true git rebase --autosquash -i origin/master
```

This will fold the fix-up commits into your branch history in one command.

### Source

Tip found in [this StackOverflow answer][so_answer] and [this Reddit
thread][reddit_thread]

[so_answer]: https://stackoverflow.com/a/29094904
[reddit_thread]:
  https://www.reddit.com/r/git/comments/uzh2no/what_is_the_utility_of_noninteractive_rebase/
