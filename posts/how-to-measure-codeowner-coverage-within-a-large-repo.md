---
title: "How to measure codeowner coverage within a large repo"
date: "2024-06-24T11:45:01+01:00"
tags: ["Unix", "Github", "Git"]
summary: ""
---

In a large monorepo, it's helpful to have a `.github/CODEOWNERS` file that maps
filepaths to owning teams, covering as much of the codebase as possible.

<!--more-->

But how do you measure how much of the codebase is covered by the codeowners
file?

There's [a useful tool for computing codeowner coverage][codeowners] but it
includes all files beneath the current folder and there's no option to only
analyse those Git's index. Thus the results need some filtering to be useful.

You can compute an ownership mapping for files in Git's index by running this
command from repo root:

```bash
join -1 1 -2 1 <(git ls-files | sort) <(codeowners | sort) > owners.txt
```

Here we compute two temporary files:

1. A list of all tracked files (`git ls-files`) and
2. The owners for every file in the repo (`codeowners`),

and inner-`join` them on their first field (the file path).

You can now compute the percentage of unowned files using `bc`:

```bash
calc="scale=2; `cat owners.txt | rg -F '(unowned)' | wc -l` / `wc -l < owners.txt`"
echo "$calc" | bc
```

[codeowners]: https://github.com/hmarr/codeowners
