---
title:
  "How to install a vendored wheel when using `pip-tools` and `pyproject.toml`"
date: "2024-05-01T17:50:21+01:00"
tags: ["Pip-tools", "Python"]
---

I had been under the impression that it was very awkward (if not impossible) to
have an application's `pyproject.toml` reference a vendored dependency (i.e.,
where the package's wheel file is committed to the repository) and work with
`pip-tools`.

The blocking problem was `pyproject.toml` only supports `file://` URLs with
absolute paths, which are not portable.

But it is possible using the `--find-links` option of `pip-compile` (and
`pip install`):

```sh
pip-compile --find-links=/path/to/wheel/dir
```

The resulting lock file will include the `--find-links` option at the top, but
won't include any absolute paths - so it is portable.

The downside is you need to be careful of supply chain attack. If there is a
package in PyPI's main index with the same name as your vendored package, then
the one with the highest version will be installed.

This can be mitigated by always pinning to the vendored version, but it's still
a vulnerability of sorts.
