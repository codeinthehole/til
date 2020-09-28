# TIL...

A Hugo-built static site of TIL posts, designed to make it as easy as possible
to publish a new post.

### Scripts

This repo provides two Bash scripts for writing a TIL post and
creating images to include.

### Publication

The TIL posts are built into a static HTML site using [Hugo](https://gohugo.io/)
and are published via Github pages.

### Hugo theme

The theme for the site is a customised version of [Etch](https://themes.gohugo.io/etch/).

### Code structure

The repo is structured to keep the TIL content separate from Hugo - all
Hugo-related content is in `/hugosite`.


## Installation

Checkout the repo and create shell aliases for the two helper scripts:

```bash
# ~/.bashrc
source /path/to/repo/install.sh
```

Consider adding this `source`ing to your Bash start-up script.

Note, the `til_screenshot.sh` script requires [`pngcrush`](https://pmt.sourceforge.io/pngcrush/)
and `imagemagick`; both of which can be installed from Homebrew:

    $ brew install pngcrush imagemagick

## Usage

Create a new post with:

    $ til $description

For example:

    $ til that cows can't look up

which will create a markdown file, named by slugifying the description (ie
`that-cows-cant-look-up.md`), pre-populated with Hugo frontmatter:

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

Eg

    $ til_screenshot Alfred's preferences UI

which will trigger MacOS's `screencapture` utility to capture a selected portion
of the screen. After selection, the resulting PNG image will be saved to
`static/images/` using a filename based on a slugified `$description` and the markdown
to include in the post will be added to the system clipboard.

After saving and exiting Vim, the markdown file and any new images will be
committed to the repo.
