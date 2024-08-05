---
title: "How to add commit sizes to `git log` output"
date: "2024-08-05T18:42:43+01:00"
tags: ["Git"]
summary: ""
---

It's _sometimes_ useful to see the sizes of each Git commit — "size" as in the
number of line additions and deletions.

I needed this recently when looking to break up a Github pull request into
smaller, easier-to-review pull requests. I wanted to split a 15 commit pull
request into 3 or 4 smaller pull requests that would require a similar amount of
cognitive effort to review. Here the number of additions and deletions was a
reasonable proxy for "review effort"; but that won't always be true.

Anyway, `git log --shortstat` has all the information you need but I wanted a
prettier, one-line version.

There's no `git log` format placeholders for additions/deletions so I needed to
use `awk` to parse the output out of `git log --shortstat` then prepend it to my
normal `git log` command:

```bash
git hist --oneline --shortstat "origin/$(git defaultbranch)".. | awk '
    $1 ~ /[a-z0-9]{12}/ {
        logline=$0;
    }
    $2 ~ /files?/ {
        print "\033[32m+" $4 " \033[31m-" $6, logline;
        logline=""
    }'
```

where:

- `git hist` is my customised one-line version of `git log`.
- `git defaultbranch` is a custom alias that returns the default branch name.
- the `awk` program captures the main log line in a `logline` variable then
  prints it along with additions and deletions (in green and red respectively)
  when it parses the appropriate `--shortstat` output.

The output is like this:

{{< figure src="/images/git-log-with-commit-sizes.png" link="/images/git-log-with-commit-sizes.png" title="" caption="" alt="git log with commit sizes" >}}
