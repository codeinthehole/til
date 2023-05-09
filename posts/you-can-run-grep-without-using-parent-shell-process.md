---
title: "You can run `:grep` without using parent shell process"
date: "2020-11-04T16:56:20+00:00"
tags: ["Vim", "ripgrep"]
---

Using [`ripgrep`](https://github.com/BurntSushi/ripgrep) as a `:grep` command
can be configured with:

```viml
set grepprg=rg\ --vimgrep
```

This is a big upgrade in performance and functionality but it has a couple of
downsides:

- Vim is suspended for the duration of the command.
- Results are printed in the parent shell, clogging it up.
- Getting back to Vim requires hitting enter.

These problems can be avoided by using `:cgetexpr` to populate the quickfix list
via a command executed with `system`. Here's a custom `:Grep` command that does
exactly that.

```viml
function! Grep(...)
    return system(join([&grepprg] + [join(a:000, ' ')], ' '))
endfunction

" Define custom commands for quickfix/location lists.
command! -nargs=+ -complete=file_in_path Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path LGrep lgetexpr Grep(<f-args>)

" Use an autocommand to automatically open the quickfix/location list if there
" are errors.
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
augroup END
```

Credit to Romain Lafourcade, who wrote this up in
["Instant grep + quickfix"](https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3).
The command I use is slightly different to his as:

- I don't use `expandcmd` as it prevents using regex special characters like
  `\b`.

- I don't use the `-bar` option when declaring the command as I want to use
  double quotes to wrap multi-word queries.
