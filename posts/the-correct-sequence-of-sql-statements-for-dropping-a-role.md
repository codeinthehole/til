---
title: "The correct sequence of SQL statements for dropping a role"
date: "2021-04-28T09:46:21+01:00"
tags: ["PostgreSQL"]
---

Suppose you create a PostgreSQL user with read-only privileges as follows:

```sql
-- Create the new role.
CREATE ROLE :username WITH LOGIN PASSWORD :'password';

-- Connect to database in question:
\c :database_name

-- Act as table owner.
SET ROLE :table_owner;

-- Grant read-only access to the new role.
GRANT CONNECT ON DATABASE :database_name TO :username;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO :username;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO :username;

-- Revoke default privileges.
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO :username;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON SEQUENCES TO :username;
```

then the appropriate sequence of statements for dropping this user is:

```sql
-- Connect to database in question:
\c :database_name

-- Act as table owner.
SET ROLE :table_owner

-- Revoke all permissions from current database.
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM :username;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM :username;
REVOKE ALL ON DATABASE :database_name FROM :username;

-- Revoke default privileges.
ALTER DEFAULT PRIVILEGES FOR ROLE :table_owner IN SCHEMA public REVOKE ALL ON TABLES FROM :username;
ALTER DEFAULT PRIVILEGES FOR ROLE :table_owner IN SCHEMA public REVOKE ALL ON SEQUENCES FROM :username;

-- Drop role.
DROP ROLE IF EXISTS :username;
```

These statements largely mirror the creation statements although the dropping of
default privileges requires a reference to the "target role" that granted these
permissions in the first place. That was the bit that was tripping me up.

[PostgreSQL docs for `ALTER DEFAULT PRIVILEGES`](https://www.postgresql.org/docs/13/sql-alterdefaultprivileges.html)
