---
title: "Vim-markdown has some useful commands"
date: "2020-12-04T17:19:14+00:00"
tags: ["Vim", "Markdown"]
---

I use [`sheerun/vim-polyglot`](https://github.com/sheerun/vim-polyglot) but
disable its `markdown` support in favour of
[`plasticboy/vim-markdown`](https://github.com/plasticboy/vim-markdown).

```vim
" ~/.vimrc

" Disable polyglot's markdown support...
let g:polyglot_disabled = ['markdown']
Plug 'sheerun/vim-polyglot'

" ...so we can use the more sophisticated vim-markdown instead.
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
```

Why? Because `plasticboy/vim-markdown` has better support for folding, front-matter
and syntax highlighting.

Also, I spotted today that it defines several useful Ex commands:

- `:HeaderIncrease` --- Increase the level of all headers in buffer/selection.

- `:Toc` --- Populate the location list with a table of contents and open it in
  a vertical window (you can use `:lnext` and `:lprev` to jump between headings).

- `:InsertToc` --- Insert a table of contents at the current line.

Will start using these more.
