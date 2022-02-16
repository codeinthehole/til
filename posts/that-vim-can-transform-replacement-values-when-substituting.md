---
title: "That Vim can transform replacement values when substituting"
date: "2021-11-15T10:46:34+00:00"
tags: ["Vim"]
---

Vim supports a range of special patterns that can transform the replacement
value when performing a search and replace.

For example, inserting `\U` will make all following characters upper case (until
the pattern ends of `\E` is encountered). So running:

```vim
:%s/name = "\(.*\)"/upper_case_name = "\U\1"/g
```

on:

```
name = "Alan"
name = "Barry"
name = "Callum"
```

will result in:

```
upper_case_name = "ALAN"
upper_case_name = "BARRY"
upper_case_name = "CALLUM"
```

Some useful transformations to be aware of:

- `\u`: Next character made upper case.
- `\U`: Following characters made upper case (until `\E`).
- `\l`: Next character made lower case.
- `\L`: Following characters made lower case (until `\E`).

See [`:help sub-replace-special`](http://vimdoc.sourceforge.net/htmldoc/change.html#sub-replace-special) for more.
