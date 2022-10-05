---
title: "How to use STDIN to populate Vim's quickfix list"
date: "2022-10-05T15:11:57+01:00"
tags: ["Vim"]
---

Vim can be opened in quickfix mode by specifying an error file with the `-q`
option:

```sh
vim -q $ERROR_FILE
```

From `man vim`:

```txt
  -q [errorfile]
       Start in quickFix mode.  The file [errorfile] is read and the first error
       is displayed.  If [errorfile] is omitted, the filename is obtained from
       the 'errorfile' option (defaults to "AztecC.Err" for the Amiga,
       "errors.err" on other systems). Further errors can be jumped to with the
       ":cn" command.  See ":help quickfix".
```

Hence you can use process substitution to populate the quickfix from STDIN. For
example:

```sh
vim -q <(flake8 $PATH_TO_FILES)
```

Something I wanted to do today was run `flake8` over a list of modified files,
that I knew would have errors, and open Vim in quickfix mode to resolve. This
can be done with:

```sh
vim -q <(git status -s | awk '$1 == "M" {print $2}' | xargs flake8)
```

An even neater trick is if you run a command that generates quickfix-compatible
output but forget to wrap it in `vim -q`. Then you can use:

```sh
vim -q <(!!)
```

Thanks to `/r/vim` legend "romainl" for [that tip][vim_comment].

[vim_comment]:
  https://www.reddit.com/r/vim/comments/7ieb3p/comment/dqy2vww/?utm_source=reddit&utm_medium=web2x&context=3
