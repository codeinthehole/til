---
title: "Pytest doesn't play nicely with ipdb"
date: "2021-03-02T12:30:06+00:00"
tags: ["Testing", "pytest", "Python"]
---

To ensure `breakpoint()` triggers [`ipdb`](https://github.com/gotcha/ipdb) as my
default debugger, I used to set:

```bash
PYTHONBREAKPOINT=ipdb.set_trace`
```

in `~/.bash_profile` (following
[this advice](https://www.andreagrandi.it/2018/10/16/using-ipdb-with-python-37-breakpoint/)).
However, this doesn't play nicely with pytest's output capturing.

Pytest has a useful feature where
[it disables output capturing if `breakpoint` is called during test execution](https://docs.pytest.org/en/stable/usage.html#setting-breakpoints),
which allows access to the debugger prompt. However, this only works if
`PYTHONBREAKPOINT` is unset. If you have `PYTHONBREAKPOINT` set to a non-empty
value, then you need to use pytest's
[`-s`](https://docs.pytest.org/en/reorganize-docs/new-docs/user/commandlineuseful.html#s-capture-no)
option to disable all output capturing. But this isn't generally desirable as it
can lead to lots of unnecessary output being printed to your terminal during
test runs.

Specifying `--pdbcls=IPython.terminal.debugger:Pdb` doesn't make any difference
if `PYTHONBREAKPOINT` is set.

A decent work-around is to not set `PYTHONBREAKPOINT` globally and install
[`pdb++`](https://pypi.org/project/pdbpp/) which provides much of the benefit of
`ipdb` (e.g. syntax highlighting, tab completion) but doesn't suffer from the
above problem; you can access the debugger without using the `-s` option.

For projects that use `ipdb`, you can set `PYTHONBREAKPOINT` on a per-project
basis.
