---
title: "About Vim's `:diffthis` command"
date: "2020-08-17T09:28:52+01:00"
tags: ["vim"]
---

You can manually compare two more open buffers by running:

```vim
:windo diffthis
```

This is an alternative to opening the files with `vimdiff`. One advantage is
that you compare buffers that aren't files (eg text pasted from the clipboard).

Further reading:

- There's some useful info in the ["Comparing buffers with vimdiff"](http://vimcasts.org/episodes/comparing-buffers-with-vimdiff/) screencast.
- [`:help :diffthis`](http://vimdoc.sourceforge.net/htmldoc/diff.html#:diffthis)

