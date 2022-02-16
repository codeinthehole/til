---
title: "Exuberant-ctags has been superceded by Universal-ctags"
date: "2020-11-16T22:10:57+00:00"
tags: ["Command-line tools"]
---

In the sense that the Exuberant ctags project has stalled, and
[Universal ctags](https://docs.ctags.io/en/latest/index.html) has been
introduced to continue development.

I discovered this while investigating why
[the `--python-kinds` flag didn't seem to work](https://stackoverflow.com/questions/46203565/exuberant-ctags-ignores-python-kinds-option)
with Exuberant ctags.

On MacOS, install Universal ctags with:

```bash
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
```
