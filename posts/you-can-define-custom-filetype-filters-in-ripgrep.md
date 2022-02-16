---
title: "You can define custom file-type filters in `ripgrep`"
date: "2020-12-29T16:23:12+00:00"
tags: ["Command-line tools", "ripgrep"]
---

[`ripgrep`](https://github.com/BurntSushi/ripgrep) lets you filter files by
their language type — e.g. search only `C`-related files:

```bash
rg 'int main' --type c
```

Here the `--type` value maps to a glob (e.g. `c` maps to `*.{c.h}`). You can
list all the available types with `rg --type-list`.

Furthermore you can
[define your own types](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#manual-filtering-file-types)
such as "web" related files:

```bash
rg --type-add 'web:*.{html,css,js}'
```

which lets you search such files with:

```bash
rg --type=web $QUERY
```

Even better, define your own types in your `$RIPGREP_CONFIG_PATH` config file:

```txt
# ~/.ripgreprc

--smart-case
--hidden
--glob=!git/*

--type-add=web:*.{html,css,js}
--type-add=django:*.{py,html}
```
