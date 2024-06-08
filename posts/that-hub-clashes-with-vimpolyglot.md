---
title: "That `hub` clashes with `vim-polyglot`"
date: "2022-12-16T21:17:06+00:00"
tags: ["Vim", "Github"]
---

I use [Github's `hub` library][hub_site] to create pull requests with a command
similar to:

```sh
hub pull-request --edit ...
```

The `--edit` option instructs `hub` to open a `.git/PULLREQ_EDITMSG` file in Vim
where the pull request title and description can be edited.

Unlike commit messages, pull request descriptions shouldn't be hard-wrapped, and
[hub sets `textwidth=0` when opening Vim][hub_pass_tw] to achieve this.

However this wasn't in effect for me as it clashed with `vim-polyglot` with sets
`textwidth=72` as part of [its `ftcommit` file-type plugin][polyglot_override].

You can see which file last set this option with:

```vim
:verbose set textwidth?
```

See my ["Debugging Vim by example"][blog_post] blog post for more tips on
debugging minor Vim issues like this one.

[hub_site]: https://hub.github.com/
[hub_pass_tw]:
  https://github.com/github/hub/blob/38bcd4ae469e5f53f01901340b715c7658ab417a/github/editor.go#L148-L149
[polyglot_override]:
  https://github.com/sheerun/vim-polyglot/blob/master/ftplugin/gitcommit.vim#L17
[blog_post]: https://codeinthehole.com/tips/debugging-vim-by-example/
