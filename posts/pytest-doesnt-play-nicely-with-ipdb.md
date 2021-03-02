---
title: "Pytest doesn't play nicely with ipdb"
date: "2021-03-02T12:30:06+00:00"
tags: ["pytest", "Python"]
---

To ensure `breakpoint()` triggers iPDB as my default debugger, I used to set:
```bash
PYTHONBREAKPOINT=ipdb.set_trace`
```
in `~/.bash_profile` (following [this advice](https://www.andreagrandi.it/2018/10/16/using-ipdb-with-python-37-breakpoint/)).
However, this doesn't play nicely with Pytest's output capturing.

Pytest has a useful feature where [it disables output capturing if `breakpoint`
is called during test execution](https://docs.pytest.org/en/stable/usage.html#setting-breakpoints).

However, this only works if `PYTHONBREAKPOINT` is unset (or set to its default
value). If you have `PYTHONBREAKPOINT` set, then you need to use Pytest's `-s`
option to disable output capturing. But this isn't generally desirable as it
can lead to lots of unnecessary output being printed to your terminal during
test runs.

Specifying `--pdbcls=IPython.terminal.debugger:Pdb` doesn't make any difference.

A decent work-around is to not set `PYTHONBREAKPOINT` and install
[`pdb++`](https://pypi.org/project/pdbpp/) which provides much of the benefit of
`ipdb` (e.g. syntax highlighting, tab completion) but doesn't suffer from the
above problem.
