---
title: "About how to use `keywordprg` effectively"
date: "2020-11-27T11:42:44+00:00"
tags: ["Vim"]
---

Hitting `K` in Vim opens the program specified by `keywordprg`, passing the
keyword under the cursor as an argument — effectively executing this:

```vim
:!{keywordprg} {keyword}
```

The default is `man -s` which is only useful if you're editing C- or
Bash-filetype buffers.

You can drastically improve this functionality by binding a more appropriate
function for each filetype you work with. For example, I have the following
scattered within my `~/.vim/after/ftplugin/` folder:

```vim
" Use built-in help when working on Vim files or browsing the help docs.

" ~/.vim/after/ftplugin/help.vim
" ~/.vim/after/ftplugin/vim.vim
setlocal keywordprg=:help

" Look-up HTML, CSS and Javascript keywords in the MDN docs.

" ~/.vim/after/ftplugin/html.vim
setlocal keywordprg=open\ https://developer.mozilla.org/search?topic=api\\&topic=html\\&q=\

" ~/.vim/after/ftplugin/css.vim
setlocal keywordprg=open\ https://developer.mozilla.org/search?topic=api\\&topic=css\\&q=\

" ~/.vim/after/ftplugin/javascript.vim
setlocal keywordprg=open\ https://developer.mozilla.org/search?topic=api\\&topic=js\\&q=\

" Use PyDoc to look-up Python keywords.

" ~/.vim/after/ftplugin/python.vim
setlocal keywordprg=pydoc
```

If it's awkward to craft an appropriate `keywordprg` snippet, write a script
that takes the keyword as the first argument and opens the relevant page.

For example, you can use the MacOS dictionary app to look-up work definitions
when working in text and markdown buffers:

```vim
" ~/.vim/after/ftplugin/markdown.vim
" ~/.vim/after/ftplugin/text.vim
setlocal keywordprg=open-dict
```

where `open-dict` is on your `$PATH` and has contents:

```bash
#!/usr/bin/env bash
set -e

function main() {
    open "dict://$1"
}

main "$1"
```

Here's a similar script for Terraform resources:

```vim
" ~/.vim/after/ftplugin/terraform.vim
setlocal keywordprg=terraform-docs
```

where `terraform-docs` is:

```bash
#!/usr/bin/env bash
set -e

function main() {
    open "$(docs_url "$1")"
}

function docs_url() {
    local provider="${1%%_*}"
    local resource="${1#*_}"
    echo "https://registry.terraform.io/providers/hashicorp/${provider}/latest/docs/resources/${resource}"
}

main "$1"
```

Ensuring `keywordprg` is mapped to something useful is a good thing to do when
starting to work with a new language.
