---
title: "`pdbpp` has a useful 'sticky' mode"
date: "2021-03-11T13:34:25+00:00"
tags: ["Python", "Debugging"]
---

`pdbpp` provides [some additional interactive commands to
`pdb`](https://github.com/pdbpp/pdbpp#new-interactive-commands). One such
command is `sticky` which toggles "sticky mode":

> When in this mode, every time the current position changes, the screen is
> repainted and the whole function shown. Thus, when doing step-by-step
> execution you can easily follow the flow of the execution.

I find this a useful mode to use.

To enable this by default, create a `~/.pdbrc.py` file with contents:

```py
import pdb
class Config(pdb.DefaultConfig):
    sticky_by_default = True
```
