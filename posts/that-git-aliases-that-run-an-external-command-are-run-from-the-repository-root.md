---
title:
  "Git aliases that run an external command are run from the repository root"
date: "2021-07-21T12:50:48+01:00"
tags: ["Git"]
---

Verify this by creating an alias in `~/.gitconfig` like so:

```dosini
pwd = "!f() { pwd; }; f"
```

and you'll find that, no matter where you call `git pwd` from, it always prints
the repository root directory.

This is annoying for `git diff --relative` aliases where it's desirable to have
the printed filepaths relative to the current directory.

For example, until five minutes ago I had this alias for printing all files
touched in a pull request:

```dosini
prfiles = "!f() { git diff --relative --name-only origin/master...HEAD; }; f"
```

but this would print the path from the repository root, meaning you couldn't
pipe the output to a command unless your current directory was the repository
root.

The solution is to use the `$GIT_PREFIX` environment variable which contains the
directory where the alias was invoked. So my `prfiles` alias is now:

```dosini
prfiles = "!f() { cd ${GIT_PREFIX:-./}; git diff --relative --name-only origin/master...HEAD; }; f"
```

Note, we define a default value of `./` as `$GIT_PREFIX` isn't set when the
alias is invoked from the repository root.

Now I can run things like:

```bash
git prfiles | xargs rg -l "foo" | xargs -o vim
```

to edit all files from my pull request that contain "foo".

The `$GIT_PREFIX` variable has been available since
[v1.7.6](https://github.com/git/git/blob/77bd3ea9f54f1584147b594abc04c26ca516d987/Documentation/RelNotes/1.7.6.txt#L29-L31)).
It's a little hard to find as it isn't mentioned in the
[current online docs on aliases](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases)
but is documented in the man pages (try `man -K GIT_PREFIX`).
