---
title: "What the sections of the Unix manual are"
date: "2021-03-22T16:06:20+00:00"
tags: ["Unix", "Documentation"]
---

From `man man`:

```txt
MANUAL SECTIONS
       The standard sections of the manual include:

       1      User Commands

       2      System Calls

       3      C Library Functions

       4      Devices and Special Files

       5      File Formats and Conventions

       6      Games et. Al.

       7      Miscellanea

       8      System Administration tools and Deamons
```

You can see the sections that have pages for a given query with `man -f` or
`whatis`. E.g.

```bash
$ man -f passwd
passwd(1)                   - modify a user's password
passwd(5), master.passwd(5) - format of the password file
slapd-passwd(5)             - /etc/passwd backend to slapd
```

The section number is in parentheses. These can be used to open a man page from
a particular section. Use:

```bash
man 1 passwd
```

to learn about how to use the `passwd` command and:

```bash
man 5 passwd
```

to learn about the format of the password file.
