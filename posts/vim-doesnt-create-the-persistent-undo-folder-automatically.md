---
title: "Vim doesn't create the persistent undo folder automatically"
date: "2020-09-04T11:38:38+01:00"
tags: ["Vim"]
---

I have this in `~/.vimrc`:

```viml
" Keep undo history between sessions
if has('persistent_undo')
    set undofile
    set undodir=~/.vim_undo
    set undolevels=2000
endif
```

but, after switching laptops, I noticed the persistent undo feature wasn't
working.

The problem was that the `~/.vim_undo` folder didn't exist which silently
prevents the feature working.

You can
[create this automaticaly in `~/.vimrc`](https://vi.stackexchange.com/questions/6/how-can-i-use-the-undofile)
if you like.
