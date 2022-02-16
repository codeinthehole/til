---
title: "About `jq`'s `--slurp` option"
date: "2021-06-17T11:15:08+01:00"
tags: ["JQ"]
---

Problem: you want to find the unique values of a key in some
[JSON Lines](https://jsonlines.org/) input using
[`jq`](https://stedolan.github.io/jq/manual/).

JQ's `unique` function requires an array as input and so we must convert the
separate JSON objects from the JSONL steam into an array. This is done using the
`--slurp` option:

{{< figure src="/images/jq-slurp-docs.png" title="" caption="" alt="jq slurp docs" >}}

Example usage:

```bash
# Find unique workspace names
$ cat workspaces.jsonl | jq --slurp '[.[].workspace_name] | unique'
```

where `[.[].workspace_name]` creates an array of all `.workspace_name` keys from
each object in the JSONL stream.
