---
title: "How to use look-behind regex assertions with `ripgrep`"
date: "2022-04-05T15:44:13+01:00"
tags: ["ripgrep", "regex"]
---

By default [`ripgrep`](https://github.com/BurntSushi/ripgrep) uses Rust's
[`regex`](https://crates.io/crates/regex) crate for parsing regular expressions
which does not support look-ahead or look-behind assertions.

To use such zero width assertions, use the `--pcre2` option:

```sh
rg --pcre2 'A(?=B)'   # look ahead positive
rg --pcre2 'A(?!B)'   # look ahead negative
rg --pcre2 'A(?<=B)'  # look behind positive
rg --pcre2 'A(?<!B)'  # look behind negative
```
