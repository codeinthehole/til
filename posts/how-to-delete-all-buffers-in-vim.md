---
title: "How to delete all buffers in Vim"
date: "2021-10-05T17:14:16+01:00"
tags: ["Vim"]
---

You can use `:%bd` (or `:%bdelete`).

This is a special form of the [`:N,Mbdelete` ranged buffer delete command](http://vimdoc.sourceforge.net/htmldoc/windows.html#:bdelete) where
`%` indicates all buffers rather than a numbered range.

I find this useful to clear down all buffers after a single logical change is
complete. This is commonly when I've reached a point where I can commit.

It's similar to dropping all your open browser tabs. It's helpful to start
working on the next logical change with a clean slate of buffers.
