---
title: "About Bash's DEBUG signal"
date: "2020-10-07T11:15:11+01:00"
tags: ["Bash"]
---

Bash has a `DEBUG` signal that you can register a handler for using `trap`.

You can use this to print a prompt before each command is executed, which allows
you to step through a Bash script:

```sh
trap '(read -p "[$BASH_SOURCE:$LINENO] $BASH_COMMAND ")' DEBUG
```

Source:

{{< tweet 1312413117436104705 >}}
