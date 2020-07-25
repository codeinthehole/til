# TIL...

Simple static site of TIL posts.

## Installation

Checkout the repo and create shell aliases for the two helper scripts:

```bash
# ~/.bashrc
source /path/to/repo/install.sh
```

## Usage

Create a new post with:

    $ til $description

For example:

    $ til that cows can't look up

which will create a markdown file, named by slugifying the description  (`ie
that-cows-cant-look-up.md`), pre-populated with Hugo frontmatter:
```markdown
---
title: "TIL that cows can't look-up"
date: "2020-07-24"
tags: []
---

```
and open Vim in insert mode with the cursor in the appropriate place. 

You then add the TIL text. 

To add screenshots, `CTRL+Z` to background Vim and use the screenshot helper:

    $ til_screenshot $description

which will trigger MacOS's `screencapture` utility to capture a selected portion
of the screen. After selection, the resulting PNG image will be saved to
`images/` using a filename based on a slugified `$description` and the markdown
to include in the post will be added to the system clipboard.

After saving and exiting Vim, the markdown file and any new images will be
committed to the repo.
