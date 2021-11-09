---
title: "That AWS Aurora clusters have two types of storage"
date: "2021-11-09T20:37:53+00:00"
tags: ["AWS", "Aurora"]
---

Aurora PostgreSQL clusters have:

- Auto-scaling storage for persistent data (the "cluster volume").

- Local storage for temporary tables or files.

There's further information in the [AWS docs](https://aws.amazon.com/premiumsupport/knowledge-center/postgresql-aurora-storage-issue/)

The amount of local storage space is tied to the instance class — more space can
only be obtained by upgrading. The amount of local storage for each instance
type doesn't seem to be published anywhere. Based on CloudWatch metric data, a
`db.r6g.xlarge` instance has 50G; [this Reddit thread has some values for
instance classes in the `r4`
series](https://www.reddit.com/r/aws/comments/a0y3ib/aurora_db_how_much_local_instance_storage_for/).

Beware that the relatively small amount of local storage can be a problem for
large table operations like changing the type of a column. We found to our cost
that 50G wasn't enough space to run a query like:
```
ALTER TABLE some_large_table ALTER COLUMN id TYPE bigint;
```
which was required as the table had exhausted all 2.7 billion IDs available to
an `integer`-type primary key field.







