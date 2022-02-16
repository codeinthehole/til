---
title: "About `git merge-base`"
date: "2021-09-08T09:29:15+01:00"
tags: ["Git"]
---

Git's `merge-base` command can be used to find the common ancestor for two
commits (or branches/references). From the
[docs](https://git-scm.com/docs/git-merge-base#_discussion):

```
Given two commits A and B, git merge-base A B will output a commit which is
reachable from both A and B through the parent relationship.

For example, with this topology:

             o---o---o---B
            /
    ---o---1---o---o---o---A

the merge base between A and B is 1.
```

This is useful for
[rebasing feature branches](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History).
This command:

```sh
git rebase -i `git merge-base head origin/master`
```

will open the interactive rebase editor with every commit from your feature
branch selected.

If you often rebase commits to create a readable, self-contained history, this
command is invaluable and I recommend you alias it to something easy to type. I
have this in my `~/.bash_aliases` file:

```
alias grb='git rebase -i `git merge-base head origin/$(git defaultbranch)`'
```

where the `defaultbranch` alias is defined in `~/.gitconfig` as:

```
[alias]
...
defaultbranch = "!f() { git symbolic-ref refs/remotes/origin/HEAD | cut -d/ -f4; }; f"
```
