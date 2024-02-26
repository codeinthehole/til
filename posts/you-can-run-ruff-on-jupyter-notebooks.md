---
title: "You can run `ruff` on Jupyter notebooks"
date: "2024-02-26T21:18:31+00:00"
tags: ["Jupyter Notebook", "Ruff"]
---

If you ensure your `pyproject.toml` contains::

```toml
[tool.ruff]
extend-include = ["*.ipynb"]
```

then `ruff` can be used to lint Jupyter notebooks (source: the [Ruff
docs][ruff_docs]).


[ruff_docs]: https://docs.astral.sh/ruff/faq/#does-ruff-support-jupyter-notebooks


