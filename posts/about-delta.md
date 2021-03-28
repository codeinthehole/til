---
title: "About delta, a viewer for Git and diff output"
date: "2021-03-19T09:42:34+00:00"
tags: ["Git", "Command-line tools"]
---

[`delta`](https://github.com/dandavison/delta) provides much improved diff views
in the terminal. It provides things like:

- Syntax highlighting with color themes

- Within-line highlights

- Side-by-side view

After `brew install git-delta`, you can configure Git to use it via something
like:

```
# ~/.gitconfig

[delta]
    features = decorations
    whitespace-error-style = 22 reverse

[delta "decorations"]
    commit-decoration-style = bold yellow box ul
    file-style = bold
    file-decoration-style = red box
    hunk-header-decoration-style = ul
```

