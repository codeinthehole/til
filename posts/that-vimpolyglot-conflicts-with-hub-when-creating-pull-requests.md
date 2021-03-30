---
title: "That `vim-polyglot` conflicts with Hub when creating pull requests"
date: "2021-03-30T16:46:39+01:00"
tags: ["Vim", "Git"]
---

[Hub](https://hub.github.com/), the Github CLI tool, allows a pull request to be
created from the command line. It does this by opening Vim like so:

```bash
$ vim --cmd set ft=gitcommit tw=0 wrap lbr .git/PULLREQ_EDITMSG
```

(As of Hub 2.14.2 at least).

However, the [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) language
pack assigns a file type of `pullrequest` to files named
`PULLREQ_EDITMSG` and so the `gitcommit` file type that Hub specifies is ignored.

This can be worked around by setting:
```vim
let g:polyglot_disabled = ['pullrequest']
```
before you load the `vim-polyglot` plugin in your `~/.vimrc` file.




