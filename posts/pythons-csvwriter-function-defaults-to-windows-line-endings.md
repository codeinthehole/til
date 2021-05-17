---
title: "Python's `csv.writer` function defaults to Windows line endings"
date: "2021-04-20T21:45:28+01:00"
tags: ["Python"]
---

I was confused as to why `awk` wasn't matching the final element in a CSV
stream from `csv.writer`. Example:

```sh
$ python -c "
> import csv, sys
> w = csv.writer(sys.stdout, delimiter='\t')
> w.writerow(['foo', 'bar'])
> " | awk '$2 == "bar" { print $1 }'
```

This _should_ print `foo` as the second element in the stream is `bar`. But it
doesn't.

This is because `csv.writer` [defaults to using Windows-style line endings
`\r\n`](https://docs.python.org/3/library/csv.html#csv.Dialect.lineterminator)
which prevents `awk` from matching the last field on each line.

The fix is to use Posix-style line endings `\n`:

```sh
$ python -c "
> import csv, sys
> w = csv.writer(sys.stdout, delimiter='\t', lineterminator='\n')
> w.writerow(['foo', 'bar'])
> " | awk '$2 == "bar" { print $1 }'
foo
```

