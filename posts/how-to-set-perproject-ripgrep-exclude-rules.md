---
title: "How to set per-project `ripgrep` and `fzf` exclude rules"
date: "2020-12-04T21:38:22+00:00"
tags: ["Command-line tools", "ripgrep"]
---

In some projects, you want `ripgrep` to ignore some files that aren't in
`.gitignore` — things like statically generated files in a Hugo site (like this
one). You can do this by adding them to a local `.ignore` file.

This also works for [`fzf`](https://github.com/junegunn/fzf).

This ensures Vim's `:grep` and `:Files` (via
[`fzf.vim`](https://github.com/junegunn/fzf.vim)) commands don't find irrelevant files.



