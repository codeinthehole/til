---
title: "That `~/.psqlrc` options can override command-line options"
date: "2023-11-01T21:36:51+00:00"
tags: ["PostgreSQL"]
---

I was trying to work out why this `psql` command wasn't printing results in
tab-separated format:

```sh
psql -d $DATABASE -AF $'\t' -c "$SQL"
```

This should work as:

- `-A` (or `--no-align`) disables aligned output.
- `-F $'\t'` indicates a tab character should be used as a field separator.

But it wasn't working.

Turns out that a setting in my `~/.psqlrc` was overriding the `-A` option:

```sql
\pset format wrap
```

To get the above command to work, the `--no-psqlrc` option was needed:

```sh
psql -d $DATABASE --no-psqlrc -AF $'\t' -c "$SQL"
```
