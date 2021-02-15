---
title: "How to use custom functions with `:cdo`"
date: "2021-02-15T14:36:46+00:00"
tags: ["Vim"]
---

Vim's `:cdo` command lets you run an Ex command in each entry in the quickfix list.
This is useful for large-scale refactoring work.

One way to leverage this is to write a macro to perform the required update then
run it with `:cdo`:

```vim
:cdo normal @q
```

Macros are powerful and many update operations can be done this way.
However, sometimes the necessary update is too complex for a macro. This happens
when there are several "categories" of update required and conditional logic is
required to determine the appropriate operation.

For such circumstances you can write a custom Vim function and call that for
each quickfix entry.

For example, I used this technique to factor out around 1,400
[F841](https://www.flake8rules.com/rules/F841.html) `flake8` violations
from a project today.

For `flake8` work, the quickfix list can be populated by
setting `makeprg=flake8` and running `:make`.

As there were several distinct categories of violation that required a separate
update operation to resolve, I created a `FixF841Error` function that
inspected the line in question to determine the appropriate remedy. Something
like this:

```vim
function! FixF841Error()
    " Example the line of the error to determine what fix is required.
    let line = getline('.')
    if line =~ 'as e:'
        " Handle scenario of unused exception variable
        ...
    elseif line =~ '^\s\+\w\+ = factory'
        " Handle scenario of unused test factory variable
        ...
    else
        echom "Unable to fix"
    endif
endfunction
```

After `source`-ing the function I ran:
```vim
:cdo call FixF841Error()
```
to resolve the majority of the errors.

Would have taken all day without this.
