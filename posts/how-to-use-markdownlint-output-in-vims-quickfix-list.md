---
title: "How to use `markdownlint` output in Vim's quickfix list"
date: "2022-02-16T13:05:21+00:00"
tags: ["Markdown", "Vim"]
---

The output from [`markdownlint-cli`][mdl] has this form:

```txt
path/to/file.md:13:81 MD013/line-length Line length [Expected: 80; Actual: 102]
```

which doesn't load correctly into Vim's quickfix list (via `:cfile` or
`:cexpr`).

This is because the error format doesn't match any of the scanf-style format
strings in the `errorformat` option.

To remedy, add a new format pattern to the list:

```vim
set errorformat+=%f:%l\ %m
```

With this adjusted, you can work through the errors in a project using;

```vim
:cexpr system('markdownlint .')
```

[mdl]: https://github.com/igorshubovych/markdownlint-cli
