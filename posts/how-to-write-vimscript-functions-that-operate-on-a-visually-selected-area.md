---
title:
  "How to write Vimscript functions that operate on a visually selected area"
date: "2023-01-28T11:57:30+00:00"
tags: ["Vim"]
---

I was trying to write a Vim function that would act on a visual selection but
found it surprisingly difficult.

As an example, suppose we want to write a function that converts a visual
selection to upper case and map it to the `,u` key binding[^1]. A first attempt
might be:

[^1]:
    This is a contrived example as [the `U` command][v_U] command already does
    this.

```viml
function! MakeUpperCase() range
    U  " or `normal! U`
endfunction

" Define visual-mode mapping
xnoremap ,u call MakeUpperCase()<cr>
```

but hitting `,u` in visual mode errors:

```txt
E464: Ambiguous use of user-defined command U
```

This is because the function body is executed in normal mode (which can be
verified by checking the value of `mode()` in the function body).

So we need to reselect the visual area first using the `<` and `>` marks that
are set when the function is called:

```viml
function! MakeUpperCase() range
    normal! `<v`>U
endfunction
```

This works.

But suppose we want a function that upper cases the contents of the paragraph
under the cursor. You might think this would work:

```viml
function! MakeCurrentParagraphUpperCase()
    " Select current paragraph
    normal! vip
    call MakeUpperCase()
endfunction

" Define a normal-mode mapping
noremap ,p call MakeCurrentParagraphUpperCase()<cr>
```

But this fails as `MakeUpperCase` is being called in visual mode.

So we extend `MakeUpperCase` to check the value of `mode()` to determine the
appropriate behaviour:

```viml
function! MakeUpperCase()
    if mode() == "v"
        normal! U
    else
        normal! `<v`>U
    endif
endfunction
```

This works in both cases.

[v_U]: https://vimhelp.org/change.txt.html#v_U
