# Today I Learnt

A Hugo-built static site of Today-I-Learnt (TIL) posts, designed to make it as
easy as possible to publish a new post.

## Scripts

This repo provides two Bash scripts:

- `scripts/til_post.sh` - Create a new TIL post with a pre-populated markdown
  file and open Vim in insert mode.

- `scripts/til_screenshot.sh` - Capture a screenshot of a selected portion of
  the screen and save it to the repo's `static/images` directory. The markdown
  to include in the post will be added to the system clipboard.

## Publication

The TIL posts are built into a static HTML site using [Hugo](https://gohugo.io/)
and published via Github pages. The compiled static site is in the `docs/`
folder.

The published site has URL: https://til.codeinthehole.com

## Hugo theme

The theme for the site is a customised version of
[Etch](https://github.com/LukasJoswiak/etch).

## Repo structure

The repo is structured to keep the TIL content separate from Hugo - all posts
live in `posts/` while all Hugo-related content is in `/hugosite`.

## Installation

Checkout the repo and create shell aliases for the two helper scripts:

```bash
# ~/.bashrc
source /path/to/repo/install.sh
```

Consider adding this snippet to your Bash start-up script.

Note, the `til_screenshot.sh` script requires
[`pngcrush`](https://pmt.sourceforge.io/pngcrush/) and `imagemagick`; both of
which can be installed from Homebrew on MacOS:

```sh
brew install pngcrush imagemagick
```

## Usage

Create a new post with:

```sh
til $description
```

For example:

```sh
til that cows cant look up
```

which will create a markdown file, named by slugifying the description (i.e.
`posts/that-cows-cant-look-up.md`), pre-populated with Hugo front matter:

```markdown
---
title: "TIL that cows can't look-up"
date: "2020-07-24"
tags: []
description: ""
---
```

and open Vim in insert mode with the cursor in the appropriate place.

You then add the TIL content.

To add screenshots, `CTRL+Z` to background Vim and use the screenshot helper:

```sh
til_screenshot $description
```

E.g.

```sh
til_screenshot Alfred preferences UI
```

which will trigger MacOS's `screencapture` utility to capture a selected portion
of the screen. After selection, the resulting PNG image will be saved to
`static/images/` using a filename based on a slugified `$description` and the
markdown to include in the post will be added to the system clipboard.

After saving and exiting Vim, the markdown file and any new images will be
committed to the repo and published to Github Pages.

## Linting and fixing

Config files are provided for:

- [Vale](https://vale.sh/) (`.vale.ini` and `vale/`) - a custom dictionary is
  kept in `vale/styles/Vocab/Local/accept.txt`.
- [MarkdownLint](https://github.com/DavidAnson/markdownlint)
  (`.markdownlint.yml`).
- [Prettier](https://prettier.io/) (`.prettierrc.yaml` and `.prettierignore`).

It is recommended that `vale` and `markdownlint` are as used as linters, and
`prettier` is used as pre-save fixer.
