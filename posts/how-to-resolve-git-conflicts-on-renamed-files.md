---
title: "How to resolve Git rebase conflicts on renamed files"
date: "2020-10-05T11:34:01+01:00"
tags: ["Git"]
---

If there's been a large-scale renaming of files in `master` and you attempt to
rebase your pull-request branch, the resulting conflicts can be tricky to
resolve. You'll see lots of conflicts of form:

```txt
CONFLICT (modify/delete): $FILEPATH deleted in HEAD and modified in $SHA... $COMMIT_MSG
```

One resolution is to manually apply the changes in `$SHA` to the new filepaths
but this is manual and error-prone.

Better is to use `git diff` to generate patch files and apply these with
`patch`.

Run this for each filepath modified in your PR but deleted in `master`:

```sh
git show REBASE_HEAD $OLD_FILEPATH | patch $NEW_FILEPATH
```

Note, `REBASE_HEAD` is a useful pseudo-ref for the conflicting commit from the
ongoing rebase.

If you're interested, I've written previously about
[resolving Git conflicts during a Git rebase](https://codeinthehole.com/guides/resolving-conflicts-during-a-git-rebase/).
