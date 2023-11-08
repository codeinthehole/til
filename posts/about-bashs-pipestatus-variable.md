---
title: "About Bash's `$PIPESTATUS` variable"
date: "2023-11-07T14:57:35+00:00"
tags: ["Bash"]
---

Problem: you have a pipeline like so:

```sh
$cmd1 | $cmd2 | $cmd3
```

and you want to detect if `$cmd1` exits with a exit code greater than 1.

I had this problem when piping `mypy` output into `grep` and then `wc` to count
the number of "untyped def" errors:

```sh
mypy $MYPY_ARGS | grep -F "[no-untyped-def]" | wc -l
```

If the `mypy` command is misconfigured, or terminated by the out-of-memory
killer, it will exit with a code greater than `1` — that's the case we want to
detect and handle. We're not interested when `mypy` exits with a `0` (no errors)
or `1` (some errors) exit code.

### Default behaviour ❌

Bash's default behaviour is for the pipeline to return the exit code of the last
command (`wc -l`), which would be `0` even if `mypy` errored.

### `PIPEFAIL` option ❌

If we set [the `PIPEFAIL` option][pipefail] (with `set -o pipefail`), then the
pipeline's return value is set to the rightmost non-zero exit code from the
pipeline. This won't work for us as `grep` will use an exit code of `1` if it
doesn't find any matches and so the pipeline's return value will be `1` if
`mypy` errors, which is indistinguishable from the happy path of `mypy` finding
some type errors.

### `$PIPESTATUS` array ✅

Instead we can use Bash's [`$PIPESTATUS` internal variable][internal_vars]. This
is an array that stores the exit code of each command within the last pipeline.
E.g.

```sh
> true | false | true
> echo "${PIPESTATUS[@]}"
0 1 0
```

We can use this to detect if the `mypy` command has returned an exit code
greater than `1`:

```sh
> mypy $MYPY_ARGS | grep -F "[no-untyped-def]" | wc -l;
> [ "${PIPESTATUS[0]}" -le 1 ]
```

Now `$?` will be `1` if `mypy` exited with a code greater than `1` and `0`.

[pipefail]:
  https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html#:~:text=pipefail
[internal_vars]: https://tldp.org/LDP/abs/html/internalvariables.html
