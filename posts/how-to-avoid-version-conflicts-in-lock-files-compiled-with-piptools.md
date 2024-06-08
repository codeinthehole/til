---
title: "How to avoid version conflicts in lock files compiled with `pip-tools`"
date: "2023-10-02T21:59:28+01:00"
tags: ["Pip-tools", "Python"]
---

Many projects I work on maintain two requirements lock files:

- `requirements.txt` for remote, production-like environments;
- `requirements.dev.txt` for development and testing environments;

compiled using `pip-compile` from [`pip-tools`].

The development requirements should always be a superset of the production ones
but it's possible for them to fall out of sync if you're not careful in updating
both lock files at the same time.

## `.in` files

If you declare packages in `requirements.in` and `requirements.dev.in` files
then starting `requirements.dev.in` with:

```txt
-r requirements.txt
```

will avoid conflicts when compiling.

## `pyproject.toml`

If you declare packages in a `pyproject.toml` file then it's best to install
both lock files in development environments:

```sh
pip-sync requirements.txt requirements.dev.txt
```

If there's a conflict between the two lock files then `pip-sync` will error.

`pip-sync` doesn't support installing packages in editable directly - you can't
run:

```sh
pip-sync requirements.txt requirements.dev.txt -e .
```

but you can work around this by creating a `requirements.local.txt` file with
contents:

```txt
-e .
```

and then install your development packages with:

```sh
pip-sync requirements.txt requirements.dev.txt requirements.local.txt
```

to ensure all packages are installed in one invocation and any conflicts are
brought to light.

Hat-tip to [Hynek Schlawack][hynek_post] for a useful post on this topic.

[`pip-tools`]: https://github.com/jazzband/pip-tools
[hynek_post]: https://hynek.me/til/pip-tools-and-pyproject-toml/
