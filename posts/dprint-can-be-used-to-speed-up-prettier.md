---
title: "`dprint` can be used to speed up Prettier"
date: "2022-04-27T09:22:58+01:00"
tags: ["Javascript", "Rust"]
---

`dprint` is a formatting platform written in Rust. It supports a Prettier plugin
that can give a big performance increase via its incremental formatting
functionality.

See [this post](https://david.deno.dev/posts/faster-prettier-with-dprint/) for
how to set-up locally.

Since I only use Prettier to format markdown, I have a `~/.dprint.json` file
with contents:

```json
{
  "includes": ["**/*.{md,markdown}"],
  "excludes": [],
  "plugins": [
    "https://plugins.dprint.dev/prettier-0.7.0.json@4e846f43b32981258cef5095b3d732522947592e090ef52333801f9d6e8adb33"
  ]
}
```

To use this as a formatter in Vim, I set `dprint` as an Ale fixer for markdown
buffers:

```vim
" ~/.vim/after/ftplugin/markdown.vim

let b:ale_fixers = ['dprint']
```
