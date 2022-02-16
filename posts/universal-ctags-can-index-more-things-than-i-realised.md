---
title: "Universal Ctags can index more things than I realised"
date: "2020-12-10T18:24:55+00:00"
tags: ["Ctags", "Vim"]
---

For instance, it can index make, markdown and ini files without custom
configuration.

List supported languages with:

```bash
ctags --list-languages
```

List the "kinds" of tag for a language with e.g.

```bash
ctags --list-kinds=python
```

Knowing what's in your local `tags` file provides for more effective use of
Vim's tag jumping functions like `:tag` and `:tselect`.

Further, it's worth ensuring `ctags` can be run without custom options in all
your projects and generate useful results. Tune your global and project-local
settings — in `~/.ctags.d/` and `$PROJECT_ROOT/.ctags.d/` respectively — to make
that so.
