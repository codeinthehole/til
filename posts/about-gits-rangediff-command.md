---
title: "About Git's `range-diff` command"
date: "2025-07-06T21:35:07+01:00"
tags: ["Git"]
summary: "How to compare two ranges of commits."
---

`git range-diff` lets you compare two ranges of commits. One way of invoking it
is:

```sh
git range-diff <old-range> <new-range>
```

I've used it recently to compare two versions of the same pull request branch,
before and after a force-push. In a GitHub action, this can be implemented as:

```sh
# Assign the before and after commit hashes to variables.
BEFORE_HEAD="{{ github.event.before }}"
AFTER_HEAD="{{ github.event.after }}"

# Compute the merge base for the before and after commits.
BEFORE_MERGE_BASE=$(git merge-base origin/main $BEFORE_HEAD)
AFTER_MERGE_BASE=$(git merge-base origin/main $AFTER_HEAD)

# Ensure we have the appropriate commits  from the remote repository.
git fetch origin $BEFORE_HEAD $AFTER_HEAD

# Compute the range-diff between the two commit ranges.
git range-diff $BEFORE_MERGE_BASE..$BEFORE_HEAD $AFTER_MERGE_BASE..$AFTER_HEAD)
```

See the [Git documentation][git_docs] for more details.

[git_docs]: https://git-scm.com/docs/git-range-diff

```

```
