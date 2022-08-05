---
title: "How to create an RST table of contents for the current page only"
date: "2022-08-05T12:36:04+01:00"
tags: ["RST", "Sphinx"]
---

To create a table of contents for the current page in reStructuredText, use the
following:

```rst
.. contents::
    :local:
```

Or, in [MyST][myst]-flavour Markdown:

````markdown
```{contents}
    :local:
```
````

This will include links to the headings of the page only. See the [`docutils`
docs][rst_contents] for other available options.

Note, this doesn't interfere with Sphinx's [`{toctree}` directives][sphinx_tocs]
and can be used to make large, leaf-node pages easier to navigate.

[myst]: https://myst-parser.readthedocs.io/en/latest/index.html
[rst_contents]:
  https://docutils.sourceforge.io/docs/ref/rst/directives.html#table-of-contents
[sphinx_tocs]:
  https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#table-of-contents
