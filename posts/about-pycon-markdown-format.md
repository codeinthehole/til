---
title: "About `pycon` markdown format"
date: "2022-07-01T14:33:52+01:00"
tags: ["Markdown", "Github"]
---

Github-flavoured markdown [uses Linguist for syntax
highlighting][gh_syntax_highlighting], and Linguist supports ["Python console"
as a language][linguist_languages].

You can use a `pycon` alias in your fenced code blocks:

[gh_syntax_highlighting]:
  https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-and-highlighting-code-blocks#syntax-highlighting
[linguist_languages]:
  https://github.com/github/linguist/blob/master/lib/linguist/languages.yml#L5121-L5129

````markdown
```pycon
>>> from pprint import pprint as pp
>>> from rich import inspect
>>> import datetime
>>> a = 1
```
````

Note that [Chroma][chroma], the syntax highlighting library used by Hugo (and
this site), doesn't support it, which is why there's no syntax highlighting in
the above code block.

[chroma]: https://github.com/alecthomas/chroma
