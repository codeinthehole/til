---
title: "That Vimium has shortcuts for following pagination links"
date: "2023-06-21T15:08:24+01:00"
tags: ["Vimium", "Github"]
---

Until today, I had Vimium disabled for Github as I believed [Github's keyboard
shortcuts][github_keyboard_shortcuts] where useful enough to warrant losing
[Vimium's][vimium].

Particularly:

- `n` and `p` — navigate to the next or parent commit when reviewing a pull
  request. Very convenient for code review.
- `Y` — [expand the current URL to its canonical, permalink][github_permalink].
  Essential for sharing URLs to file content (as otherwise the page content can
  change over time).

But I discovered Vimium can be enabled for Github without losing the above
functionality.

- Vimium provides `[[` and `]]` to navigate to the next and previous commit when
  reviewing a pull request. These shadow the quickfix navigation mappings from
  [`vim-unimpaired`][vim-unimpaired]. More broadly, these work with various
  forms of "previous" or "next" pagination links.

- Github's `Y` shortcut can still be accessed by entering "insert mode" first.
  So use `iY` instead.

[github_keyboard_shortcuts]:
  https://docs.github.com/en/get-started/using-github/keyboard-shortcuts
[github_permalink]:
  https://docs.github.com/en/repositories/working-with-files/using-files/getting-permanent-links-to-files
[vim-unimpaired]: https://github.com/tpope/vim-unimpaired
[vimium]: https://vimium.github.io/
