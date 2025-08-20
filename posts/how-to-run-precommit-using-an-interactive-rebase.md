---
title: "How to run pre-commit using an interactive rebase"
date: "2025-05-09T21:49:28+01:00"
tags: ["Git", "Pre-commit"]
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

after each commit in the rebase todo list.

You can edit or remove the commands if you like. You can even add `exec` lines
manually even if you didn't start the rebase with the `--exec` option.

## Running pre-commit hooks

To run your `pre-commit` hooks on each commit in an interactive rebase, use:

```bash
git rebase -i --exec "pre-commit run --hook-stage commit --from HEAD^ --to=HEAD" \
    $ref
```

To run a command after every commit on your pull request branch without rebasing
your commits against a different ref, drop the `-i` flag:

```bash
git rebase --exec '$command' $ref
```

The rebase will stop if `$command` fails, so you can fix the issue and continue.

For a feature branch based on `main`, run:

```bash
git rebase --exec 'pre-commit run --hook-stage commit --from HEAD^ --to=HEAD' \
    $(git merge-base main HEAD)
```

to check your pre-commit hooks pass on every commit.

This can be extended to verify that pre-commit hooks pass on _the whole repo_
(not just the files modified in a commit) after each commit:

```bash
git rebase --exec 'pre-commit run --hook-stage commit --all-files' \
    $(git merge-base main HEAD)
```

This is useful if you've rebased your pull request branch and want to verify
that each commit is still atomic and passes all pre-commit checks.
