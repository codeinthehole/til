---
title: "That Postgres sequences aren't restored after a transaction rollback"
date: "2022-10-18T17:43:06+01:00"
tags: ["PostgreSQL", "Testing"]
---

Verify by creating a table and inserting a single row

```psql
# create table people ( id SERIAL, name TEXT );
# \d people
                             Table "public.people"
┌────────┬─────────┬──────────┬────────────────────────────────────┐
│ Column │  Type   │ Nullable │              Default               │
├────────┼─────────┼──────────┼────────────────────────────────────┤
│ id     │ integer │ not null │ nextval('people_id_seq'::regclass) │
│ name   │ text    │          │                                    │
└────────┴─────────┴──────────┴────────────────────────────────────┘
# insert into people (name) values ('Alan');
```

then the next `id` to be allocated will be `2`:

```psql
# select currval('people_id_seq') + 1 as next_val;
┌──────────┐
│ next_val │
├──────────┤
│        2 │
└──────────┘
```

Now open a transaction and insert a new row, which increments the
`people_id_seq` sequence, then roll back:

```psql
# start transaction;
# insert into people (name) values ('Barry');
# rollback;
```

There's still only one row in the table, but the next available `id` is now `3`:

```psql
# table people;
┌────┬──────┐
│ id │ name │
├────┼──────┤
│  1 │ Alan │
└────┴──────┘
(1 row)
# select currval('people_id_seq') + 1 as next_val;
┌──────────┐
│ next_val │
├──────────┤
│        3 │
└──────────┘
```

Hence rolling back a transaction does not restore the sequence associated with
its primary key.

There's a cautionary note about this in the [Postgres docs on sequence
manipulation functions][postgres_sequences]:

{{< figure src="/images/postgres-docs-on-sequences.png" title="" caption="" alt="postgres docs on sequences" >}}

[postgres_sequences]:
  https://www.postgresql.org/docs/current/functions-sequence.html

## Flakey tests

This phenomena can cause flakey tests, which is how I became aware of it.

By default, Django executes tests in a transaction that's rolled back as part of
the test's tear-down phase. This means that any data inserted into a test
database isn't readable to subsequent tests (and can't pollute them).

But, as per the above, sequences _are mutated_ and so tests do affect the
primary keys allocated in subsequent tests. This is a subtle form of test
pollution.

The flakiness occurs when a test hard-codes the value of a primary key. For
example:

```py
# Some factory class that inserts rows into a Postgres table.
from factories import FrobFactory

def test_create_frobs():
    # Insert a row into a table using the default sequence to provide the ID.
    FrobFactory()

    # Insert a second row but hard-code the ID.
    FrobFactory(id=123)
```

This test can fail if the first `FrobFactory` instance is allocated a primary
key of `123`, meaning the second `FrobFactory` call will error on a uniqueness
constraint.

Whether this happens depends on the tests that run beforehand. If the prior
tests insert 122 rows to the table then the first `FrobFactory` call in this
test will be given an `id` of `123`.

This fails intermittently as it depends on the order and constituents of your
test suite, which will change as new tests are added.

Rule-of-thumb? Avoid hard-coding primary keys in your test fixtures.
