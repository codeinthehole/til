---
title: "About Bash's `$SECONDS` shell variable"
date: "2021-11-26T15:19:29+00:00"
tags: ["Bash"]
---

Bash provides a `$SECONDS` environment variable which, if used in a script,
returns the number of seconds since the script was started.

From `man bash`:

```txt
SECONDS
  Each time this parameter is referenced, the number of seconds
  since shell invocation is returned. If a value is assigned to
  SECONDS, the value returned upon subsequent references is the
  number of seconds since the assignment plus the value assigned.
  The number of seconds at shell invocation and the current time
  is always determined by querying the system clock. If SECONDS
  is unset, it loses its special properties, even if it is
  subsequently reset.
```

Here's a neat way of employing it with the [`timeout`](https://ss64.com/bash/timeout.html) command, taking from [Shell Scripting: Expert Recipes
for Linux, Bash and More](https://www.oreilly.com/library/view/shell-scripting-expert/9781118166321/c03-anchor-3.xhtml)

```bash
#!/bin/bash

# Reset timer.
SECONDS=0

# Run slow command with a max execution time of 60 seconds and capture the exit
# code.
timeout 60s slow_command
timeout_res=$?

# The exit code will be 124 if the timeout was reached but we need to be
# careful of the scenario where the `slow_command` exited within 60 seconds with a
# code of 124. We use the `$SECONDS` timer to do that.
if [ "$SECONDS" -lt "60" ]; then
    # Command did not time out; the exit code is from `slow_command`.
    echo "The command did not time out; it returned after $SECONDS seconds."
else
    # Command did time out.
    echo "The command timed out."
fi
```






