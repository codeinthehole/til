---
title: "How to create custom replacements for `vim-surround`"
date: "2023-11-27T14:59:48+00:00"
tags: ["Vim", "Markdown"]
---

## Problem

I forgot my notepad and was editing a `todo.md` buffer in Vim as a replacement
checklist.

Rather than deleting completed lines, I wanted to wrap them in `~~` to [strike
them out][github_styling] (so I could remember what I had done that day).

This was awkward as `vim-surround` doesn't have a default mapping for `~~`.

## Solution

Define a custom replacement for Markdown-filetype buffers:

```vim
" ~/.vim/after/ftplugin/markdown.vim
let b:surround_{char2nr('s')} = "~~\r~~"
```

Now `s` can be used to surround text with `~~` in Markdown buffers. Example
usage:

- `ysiws` wrap current word in `~~`
- `ysss` wrap current line in `~~`

See the [`vim-surround` help documentation][docs] for more details on
customisation.

[github_styling]:
  https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#styling-text
[docs]:
  https://github.com/tpope/vim-surround/blob/3d188ed2113431cf8dac77be61b842acb64433d9/doc/surround.txt#L151-L162
