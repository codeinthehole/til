---
title: "How to configure the coloured output of `eza`"
date: "2024-07-31T13:50:58+01:00"
tags: ["Eza", "Command-line tools"]
summary: ""
---

After a recent `brew upgrade` I discovered that [`exa`], the modern replacement
for `ls`, had stopped being maintained and had been replaced by [`eza`].

[`exa`]: https://github.com/ogham/exa
[`eza`]: https://github.com/eza-community/eza

<!--more-->

Hence, after installing `eza`, I updated my shell aliases:

```sh
alias ls='eza'
alias ll='eza --long --no-permissions --no-user --time-style=long-iso --total-size'
```

where `ll` is a long listing which removes permission and user information, and
includes the total size of directories. E.g.

{{< figure src="/images/ezaoutput.png" link="/images/ezaoutput.png" title="" caption="" alt="eza-output" >}}

🤔 but why is the `README.md` highlighted differently from other Markdown files
like `CHANGELOG.md`?

## Build files

This is because `eza` distinguishes between various file types and highlights
them in different colours. `README.md`, `pyproject.toml` and `makefile` are
classified as "build" files (code `bu`) - that is, text files required to build
a project. See the [`filetype.rs`] file for more info on how specific file types
are classified.

[`filetype.rs`]:
  https://github.com/eza-community/eza/blob/65a08a672ad9fe92cf12f508c0ea8b38e82ccf11/src/info/filetype.rs

But `CHANGELOG.md` is not classified as a build file, so it is highlighted
differently. Bit jarring - can we configure `eza` to highlight `CHANGELOG.md` in
the same way as `README.md`?

## Configuration

You can use an `EZA_COLORS` environment variable to configure `eza` syntax
highlighting. It has a CSV format of `key=value:key=value:...` using `:` to
delimit key-value pairs, where:

- `key` is either a two-letter file-type code, or a glob pattern.
- `value` is a `;`-seperated sequence of ANSI color codes (or the special value
  `reset`).

So setting:

```sh
export EZA_COLORS='CHANGELOG.md=1;4;93'
```

ensures `CHANGELOG.md` files are printed in bold (`1`), underlined (`4`), bright
yellow (`93`) - the same as `README.md` files.

More info:

- [`eza` color explanation](https://github.com/eza-community/eza/blob/main/man/eza_colors-explanation.5.md)
- [`eza` list of filetype and color codes](https://github.com/eza-community/eza/blob/main/man/eza_colors.5.md)
