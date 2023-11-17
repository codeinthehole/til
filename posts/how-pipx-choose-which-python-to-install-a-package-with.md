---
title: "How `pipx` chooses which Python to install a package with"
date: "2023-11-17T11:14:27+00:00"
tags: ["Python", "pipx", "LLM"]
---

[`pipx`][pipx] is a tool for installing standalone Python packages in isolated
environments. It's useful for managing Python CLI tools that you want available
globally and not confined to one virtualenv. Things like:

[pipx]: https://pypa.github.io/pipx/

- [`aws-mfa-v2`](https://pypi.org/project/aws-mfa-v2/) --- temporary AWS
  sessions using MFA
- [`llm`](https://llm.datasette.io/en/stable/) --- CLI access to Large Language
  Models
- [`yamllint`](https://pypi.org/project/yamllint/) --- YAML linting

Syntax for installing a package is:

```sh
pipx install $package
```

## Package installation problem?

After switching to a new laptop, `llm` wouldn't install:

```
> pipx install llm
Fatal error from pip prevented installation. Full pip output in file:
    ~.local/pipx/logs/cmd_2023-11-17_11.07.16_pip_errors.log

pip failed to build package:
    aiohttp

Some possibly relevant errors from pip install:
    error: subprocess-exited-with-error
    aiohttp/_websocket.c:3042:55: error: no member named 'ob_digit' in 'struct _longobject'
    aiohttp/_websocket.c:3097:55: error: no member named 'ob_digit' in 'struct _longobject'
    aiohttp/_websocket.c:3238:55: error: no member named 'ob_digit' in 'struct _longobject'
    aiohttp/_websocket.c:3293:55: error: no member named 'ob_digit' in 'struct _longobject'
    aiohttp/_websocket.c:3744:47: error: no member named 'ob_digit' in 'struct _longobject'
    error: command '/usr/bin/clang' failed with exit code 1

Error installing llm.
```

A little digging revealed the latest version of `aiohttp` didn't support Python
3.12, hence the compilation error. So `pipx` must be using Python 3.12 to
install packages.

## How does `pipx` choose which Python to use?

From [the docs][pipx_install]:

> The default python executable used to install a package is typically the
> python used to execute pipx and can be overridden by setting the environment
> variable `PIPX_DEFAULT_PYTHON`.

[pipx_install]: https://pypa.github.io/pipx/docs/

I installed `pipx` from Homebrew and the relevant Python can be seen in the
package info:

```sh
> brew info pipx | rg "Required.*python"
Required: python-argcomplete, python-packaging, python@3.12
```

As suspected: `python@3.12`.

## How to install packages with a different Python version?

`pipx install` supports a `--python` flag that can be used to specify a
different Python. I'm using `pyenv` to marshall local Python versions; you can
determine the path to a given version like so:

```sh
> cd /tmp
> pyenv local 3.11.6
> PYTHON_PATH=$(pyenv which python)
```

then `llm` can be installed:

```
pipx install --python $PYTHON_PATH llm
```
