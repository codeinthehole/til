---
title: "How to use `ripgrep` in `while read` loops"
date: "2023-03-03T11:23:32+00:00"
tags: ["ripgrep"]
---

Beware of using `rg` in a `while read` block when there's no path argument.

For example, this loop:

```bash
print_search_patterns | while read pattern; do
    # Print a warning if this pattern isn't found in a HTML file.
    matches=$(rg "$pattern" -thtml)
    [[ $matches -eq 0 ]] && echo "Warning: $pattern not found in any HTML files"
done
```

will only search the _first line_ of the `print_search_patterns` output. This
happens as `rg` will consume all of STDIN if no path argument is given.

To avoid this problem either specify a path argument to `rg`:

```bash
print_search_patterns | while read pattern; do
    matches=$(rg "$pattern" -thtml .)  # Note dot argument
    [[ $matches -eq 0 ]] && echo "Warning: $pattern not found in any HTML files"
done
```

or explicitly close STDIN:

```bash
print_search_patterns | while read pattern; do
    matches=$(rg "$pattern" -thtml </dev/null)  # Note input redirection
    [[ $matches -eq 0 ]] && echo "Warning: $pattern not found in any HTML files"
done
```

More info in this [`rg` issue][rg_issue].

A similar problem exists when using `ssh` in a `while read` loop (for which it
has the `-n` option).

[rg_issue]: https://github.com/BurntSushi/ripgrep/issues/1219
