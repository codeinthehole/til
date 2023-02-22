---
title: "About the `typos` source code spell checker"
date: "2023-02-22T21:13:57+00:00"
tags: ["Command-line tools", "Rust", "Vim"]
---

[`typos`][github_typos] is a source code spell checker written Rust that's
useful for finding typos in code comments and variable names.

On MacOS you can install from Homebrew:

```sh
brew install typos-cli
```

and run with:

```sh
typos
```

It does tend to yield some false positives but it's still useful.

## Fixing typos in a project

I use it to populate Vim's quickfix list via:

```viml
:cexpr system('typos --format=brief')
```

then use `,z` to replace the word under cursor with the top spelling suggestion,
which is usually right:

```viml
" ~/.vimrc

" Replace word under cursor with top spelling suggestion
nnoremap <leader>z 1z=
```

Haven't tried it as a pre-commit hook or CI step yet but will investigate.

[github_typos]: https://github.com/crate-ci/typos
