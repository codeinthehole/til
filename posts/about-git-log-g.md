---
title: "About `git log -G`"
date: "2021-06-02T13:00:25+01:00"
tags: ["Git"]
---

`git log` supports two options for searching the contents of each commit's
patch:

- [`-S<string>`](https://git-scm.com/docs/git-log#Documentation/git-log.txt--Sltstringgt) — look for patches containing a fixed string. Technically, this option looks for
differences in the number of occurrences of a string in a file.
- [`-G<regex>`](https://git-scm.com/docs/git-log#Documentation/git-log.txt--Gltregexgt) — look for patches matching a regex.

The `-G` option can be useful to add a word boundary character to a fixed
string. So instead of:

```bash
$ git log -S my_string
```

use:

```bash
$ git log -G "\<my_string\>"
```

to avoid unwanted matches (like `my_string_with_extra_stuff`).

These filtering options are best used with the [`-p` or
`--patch`](https://git-scm.com/docs/git-log#Documentation/git-log.txt---patch) option to show
the commit diff of files that contain the searched-for string/regex. To see the diff
of _all_ files in each matching commit, use the [`--pickaxe-all`](https://git-scm.com/docs/git-log#Documentation/git-log.txt---pickaxe-all) option too.
