---
title: "Vim recommends using Emacs-style key bindings in command mode"
date: "2020-09-16T09:16:47+01:00"
tags: ["Vim"]
---

As in, using these command-mode maps:

```txt
" start of line
:cnoremap <C-A>		<Home>
" back one character
:cnoremap <C-B>		<Left>
" delete character under cursor
:cnoremap <C-D>		<Del>
" end of line
:cnoremap <C-E>		<End>
" forward one character
:cnoremap <C-F>		<Right>
" recall newer command-line
:cnoremap <C-N>		<Down>
" recall previous (older) command-line
:cnoremap <C-P>		<Up>
" back one word
:cnoremap <Esc><C-B>	<S-Left>
" forward one word
:cnoremap <Esc><C-F>	<S-Right>
```

See http://vimdoc.sourceforge.net/htmldoc/tips.html#emacs-keys
