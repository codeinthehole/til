---
title: "About Vim's semi-colon search offset"
date: "2021-05-14T12:46:44+01:00"
tags: ["Vim"]
---

A search with `/` or `?` can include an additional offset to position the cursor
after jumping to the search match. From [the docs](http://vimdoc.sourceforge.net/htmldoc/pattern.html#search-offset):

```
pattern   cursor position
/test/+1  one line below "test", in column 1
/test/e   on the last t of "test"
/test/s+2  on the 's' of "test"
/test/b-3  three characters before "test"
```

A special offset is `;` which lets you position the cursor by doing a second
search (normally within the same line as the original match). E.g.

```
/test_.*_errors/;/errors
```

which will position the cursor on the `errors` part of each search match.

Useful for repeating common changes in a buffer using `n.n.n.` etc.
