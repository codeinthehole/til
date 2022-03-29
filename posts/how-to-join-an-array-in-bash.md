---
title: "How to join an array in Bash"
date: "2022-03-29T17:27:59+01:00"
tags: ["Bash"]
---

Say you want to build an array of values then print them out as a tab-separated
line:

```bash
# Build an array.
row=(
    "one"
    "two"
    "three"
)

# Set the internal field separator to the tab character.
IFS=$'\t';

# Echo the array.
echo "${row[*]}";
```

To understand how this works, consider the explanation of `$*` from the [Bash
Beginners Guide][bash_guide]:

> `$*` Expands to the positional parameters, starting from one. When the
> expansion occurs within double quotes, it expands to a single word with the
> value of each parameter separated by the first character of the IFS special
> variable.

[bash_guide]: https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html

In the above example we set `IFS` to be a tab character using [`ksh93`
syntax][ksh], then echo the array using `$*` syntax which ensures the fields are
joined using a tab character.

[ksh]:
  https://www.man7.org/linux/man-pages/man1/bash.1.html#:~:text=Words%20of%20the%20form%20%24%27string%27%20are%20treated%20specially.

Note that print arrays with `*@` doesn't have this behaviour:

> `$@` Expands to the positional parameters, starting from one. When the
> expansion occurs within double quotes, each parameter expands to a separate
> word.
