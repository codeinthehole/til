---
title: "How to use `xargs` with `printf`"
date: "2020-09-29T12:47:23+01:00"
tags: ["Command-line tools"]
---

This is obvious in retrospect but it hadn't dawned on me that you can use
`xargs printf` to use STDIN as `printf` arguments. Trivial example:

```bash
$ echo world | xargs printf "hello %s"
hello world
```

It's useful for building strings from streams of data. Today's usecase was
building a pastable Python snippet from a JSON file containing object IDs:

```bash
$ cat loggly_events.json | jq '.events[].event.json.object_id' \
    | paste -sd, | xargs printf "object_ids = [%s]"
object_ids = [4,6,8,2,3,4]
```

Here `jq` is used to extract a newline-separated stream of IDs which are joined
into a CSV-string using `paste` before being formatted into a Python snippet
with `printf`.
