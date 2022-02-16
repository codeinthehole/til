---
title: "About `readonly` Bash variables"
date: "2020-10-13T16:02:02+01:00"
tags: ["Bash"]
---

Doing this:

```bash
readonly myvar=1
```

means that `$myvar` can't have its value changed within the global scope.

```bash
$ myvar=2
-bash: myvar: readonly variable
```

You can use `declare -r` to enforce immutability within a _local_ scope (eg within a
function body).

See [the Linux Shell Scripting Tutorial wiki](https://bash.cyberciti.biz/guide/Readonly_command) for basic examples.
See [this Stack Overflow answer](https://stackoverflow.com/a/30362832) for more details on the differences between
  `readonly` and `declare -r`.
