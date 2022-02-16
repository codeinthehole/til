---
title: "How to use Bandit with Vim's quickfix list"
date: "2020-11-19T10:54:49+00:00"
tags: ["Vim", "Security"]
---

One way to populate Vim's quickfix list is by running `:make` which runs the
program specified by the `makeprg` setting. Due to Vim's C heritage, the default
behaviour is to run the `make` command-line tool but there are many other useful
programs that print locations to stdout.

[Bandit](https://bandit.readthedocs.io/en/latest/) is a Python static analysis
tool that looks for common security issues. You can use it to populate the
quickfix list by setting:

```vim
set makeprg=bandit\ -r\ -f\ custom
```

then you can run `:make` to work through any warnings with `:cwindow`, `:cnext`
etc.

Note, `:make` will pass on any command-line options so you can do things like
`:make -t B112` to work though just one type of warning.

You can do a similar thing for linting errors by setting `makeprg=flake8`.
