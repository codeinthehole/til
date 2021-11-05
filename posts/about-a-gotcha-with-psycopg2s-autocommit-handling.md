---
title: "About a gotcha with `psycopg2`'s autocommit handling"
date: "2021-11-05T16:54:26+00:00"
tags: ["PostgreSQL", "Python"]
---

Some commands in Postgres can't be run inside a transaction (e.g. running
`VACUUM FULL` or creating indexes concurrently); they require `autocommit` mode to
be enabled on the connection.

However there is a subtle gotcha when doing this as if you execute
multiple statements then a transaction is implicitly created leading to an error.

```py
conn = psycopg2.connect(...)
conn.autocommit = True
cur = conn.cursor()
cur.execute("VACUUM FULL; SELECT 1")
# exception: ActiveSqlTransaction: VACUUM cannot run inside a transaction block
```

I lost an hour of my life this week tracking this down until I
stumbled upon [this StackOverflow answer](https://stackoverflow.com/a/67418518) and
[related `psycopg2` issue](https://github.com/psycopg/psycopg2/issues/1201).




