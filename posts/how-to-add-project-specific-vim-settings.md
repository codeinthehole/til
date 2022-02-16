---
title: "How to add project-specific Vim settings"
date: "2020-12-18T09:46:49+00:00"
tags: ["Vim"]
---

There's various ways to do this but I quite like using an  `autocmd` based on
a buffer's filepath. For example:

```vim
" ~/.vim/vimrc
function ConfigureKrakenCore()
    nnoremap <leader>ct :!ctags --languages=python<cr>
endfunction

autocmd BufRead */kraken-core/* call ConfigureKrakenCore()
```

In this case, I wanted to customise my `,ct` mapping (that runs `ctags`) to only
index Python files as the "kraken-core" project has reams of Javascript that I
don't want indexing (as it takes ages). This is a preference particular to me so
it would be inappropriate to hard-code configuration to the repo (via, say, a
`.ctags.d/project.ctags` file).

Note, we're `call`ing a function so it's easier to add new project-specific settings later on.

Another option is to `set exrc` and use a per-project `.vimrc` file (kept out of
source control). See:

- [Using .vimrc for project specific settings](https://akrabat.com/using-vimrc-for-project-specific-settings/)

- [Vim tips wiki: Project specific settings](https://vim.fandom.com/wiki/Project_specific_settings)

- [Hashrocket TIL: Matching on directories for Vim's autocmd](https://til.hashrocket.com/posts/720a6a05f9-matching-on-directories-for-vims-autocmd)
