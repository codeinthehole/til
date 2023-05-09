---
title: "How to set per-role statement timeouts in Postgres"
date: "2023-05-09T16:52:32+01:00"
tags: ["PostgreSQL"]
---

Postgres has a [`statement_timeout` setting][postgres_docs_config] that will
abort statements that run longer than the specified number of milliseconds.

This can be set globally in `postgresql.conf` but, perhaps more usefully, can be
set on a per-role basis via:

```sql
=> ALTER ROLE webserver SET statement_timeout = '50s';
```

You can check what a role's config is with e.g.

```sql
=> SELECT rolname, rolconfig FROM pg_roles WHERE rolname = 'webserver';
    rolname    |        rolconfig
---------------+-------------------------
 webserver     | {statement_timeout=50s}
 (1 row)
```

## HTTP servers

If you're using uWSGI, a useful pattern is to set a statement timeout slightly
higher than your [`harakiri` timeout value][uwsgi_harakiri] so long-running
queries from HTTP servers will be aborted shortly after the uWSGI worker is
killed.

[postgres_docs_config]:
  https://www.postgresql.org/docs/current/runtime-config-client.html
[uwsgi_harakiri]:
  https://uwsgi-docs.readthedocs.io/en/latest/Options.html#harakiri
