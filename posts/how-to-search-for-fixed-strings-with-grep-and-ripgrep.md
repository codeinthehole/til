---
title: "How to search for fixed strings with `grep` and `ripgrep`"
date: "2021-01-12T09:37:14+00:00"
tags: ["ripgrep", "Command-line tools"]
---

To search for a fixed string (i.e. not a regex), use:

```bash
grep -F -- "$query"
```

or, better:

```bash
rg -F -- "$query"
```

Note, the `--` tells Bash there are no more options and any further arguments
are positional. This is required to search for queries that _look like_ options,
like `-v` or `->`. From `man bash`:

```txt
 --    A -- signals the end of options and disables further option processing.
       Any arguments after the -- are treated as filenames and arguments. An
       argument of - is equivalent to --.
```

I noticed this when doing a quick search for symlinks in my home directory.
Using the incorrect:

```bash
ls -la ~ | grep -F "->"
```

causes `grep` to complain about an unknown option.

```txt
grep: invalid option -- >
usage: grep [-abcDEFGHhIiJLlmnOoqRSsUVvwxZ] [-A num] [-B num] [-C[num]]
 [-e pattern] [-f file] [--binary-files=value] [--color=when]
 [--context[=num]] [--directories=action] [--label] [--line-buffered]
 [--null] [pattern] [file ...]
```

For the record, a more robust way of listing symlinks in a directory is:

```bash
find ~ -type l -maxdepth 1
```

although that doesn't show where they link to.
