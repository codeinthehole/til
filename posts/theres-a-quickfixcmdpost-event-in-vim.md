---
title: "There's a `QuickFixCmdPost` event in Vim"
date: "2020-11-04T11:55:58+00:00"
tags: ["Vim"]
---

Which you can target in an `autocmd` to open the quickfix window whenever a
quickfix command populates the error list (e.g. `:make` or `:grep`):

```vim
autocmd QuickFixCmdPost [^l]* cwindow
```

Taken from https://gist.github.com/romainl/ce55ce6fdc1659c5fbc0f4224fd6ad29



