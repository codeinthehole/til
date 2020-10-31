---
title: "You can jump to previous quickfix lists in Vim"
date: "2020-10-31T11:39:36+00:00"
tags: ["Vim"]
---

Vim remembers the previous ten quickfix lists; you can list them with:
```vim
:chistory
  error list 1 of 3; 70 errors    :rg --vimgrep --smart-case search
  error list 2 of 3; 61 errors    :rg --vimgrep --smart-case what
> error list 3 of 3; 187 errors   :rg --vimgrep --smart-case how
```

You can activate a particular list using its index (e.g. `:1chi` to select the
1st error list) or by browsing with `:colder` and `:cnewer`.

There's a rather glorious section in the `quickfix.txt` help file on how to use
nested quickfix lists to browse source-code:

```txt
5.5 Browsing source code with :vimgrep or :grep

Using the stack of error lists that Vim keeps, you can browse your files to
look for functions and the functions they call.  For example, suppose that you
have to add an argument to the read_file() function.  You enter this command: >

	:vimgrep /\<read_file\>/ *.c

You use ":cn" to go along the list of matches and add the argument.  At one
place you have to get the new argument from a higher level function msg(), and
need to change that one too.  Thus you use: >

	:vimgrep /\<msg\>/ *.c

While changing the msg() functions, you find another function that needs to
get the argument from a higher level.  You can again use ":vimgrep" to find
these functions.  Once you are finished with one function, you can use >

	:colder

to go back to the previous one.

This works like browsing a tree: ":vimgrep" goes one level deeper, creating a
list of branches.  ":colder" goes back to the previous level.  You can mix
this use of ":vimgrep" and "colder" to browse all the locations in a tree-like
way.  If you do this consistently, you will find all locations without the
need to write down a "todo" list.
```

