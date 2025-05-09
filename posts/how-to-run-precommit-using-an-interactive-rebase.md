---
title: "How to run pre-commit using an interactive rebase"
date: "2025-05-09T21:49:28+01:00"
tags: ["Git"]
summary: "Using `git rebase` to run shell commands on each commit"
---

To run a shell command on each commit in an interactive rebase, use:

```bash
git rebase -i --exec "$command" $ref
```

which adds:

```bash
exec $command
```

after each commit in the rebase todo list. You can edit or remove the commands
if you like. You can even add `exec` lines manually even if you didn't start the
rebase with the `--exec` option.

So to run your `pre-commit` hooks on each commit in an interactive rebase, use:

```bash
git rebase -i --exec "pre-commit run --hook-stage commit --from HEAD^ --to=HEAD" \
    $ref
```

If you simply want to run some command after every commit on your pull request
branch without rebasing your commits against a different ref, drop the `-i`
flag:

```bash
git rebase --exec '$command' $ref
```

So, for a feature branch based on `main`, run:

```bash
git rebase --exec 'pre-commit run --hook-stage commit --from HEAD^ --to=HEAD' \
    $(git merge-base main HEAD)
```

to check your pre-commit hooks pass on every commit.
