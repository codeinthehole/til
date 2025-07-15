---
title:
  "That `while read` loops ignore single line inputs (with no newline character)"
date: "2025-07-15T15:38:29+01:00"
tags: ["Bash", "Git"]
summary: "Need to ensure input has a newline character."
---

A Bash script I was working on had a `while read` loop that processed Git commit
SHAs:

```bash
git log --pretty=format:'%H' $OPTIONS | while read -r line; do
    ...
done
```

but it did nothing when the `git log` command only piped one SHA in. Why?

<!--more-->

Because `read` is designed to work with sequences of lines and lines need to end
with a newline character. In this case, the piped input had no newline character
and so `read` doesn't process it.

Verify for yourself with:

```bash
printf "example" | while read -r line; do echo "$line"; done
```

which doesn't print anything, and see
[this Stack Overflow answer](https://unix.stackexchange.com/a/418081) for a more
detailed explanation.

My script was fixed by including an additional `%n` format option which ensures
each line ends with a newline character and the `while read` loop works as
expected:

```bash
git log --pretty=format:'%H%n' $OPTIONS | while read -r line; do
    ...
done
```

## Spotting missing hidden characters

A useful technique for comparing two strings that look the same is to run `diff`
on their hexdump with `xxd` (or `hexdump`). E.g. compare the output of using
`printf` and `echo` with the same string:

```bash
> diff <(printf "example" | xxd) <(echo "example" | xxd)
1c1
< 00000000: 6578 616d 706c 65                        example
---
> 00000000: 6578 616d 706c 650a                      example.
```

Here you see that `echo` appends a line feed character (hex `0a`).
