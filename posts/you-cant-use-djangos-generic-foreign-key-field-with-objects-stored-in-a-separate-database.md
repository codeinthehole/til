---
title: "You can't use Django's generic foreign key field with objects stored in a separate database"
date: "2022-02-02T11:55:29+00:00"
tags: ["Django", "Python"]
---

Django supports using separate databases for specified models or apps. This is
done using [custom database routers](https://docs.djangoproject.com/en/4.0/topics/db/multi-db/#automatic-database-routing).

However Django's [generic foreign
keys](https://docs.djangoproject.com/en/4.0/ref/contrib/contenttypes/#generic-relations) should not be used to link to instances
that live in a different database from where the foreign key field will be
stored.

This is because Django (up to v4.0.2 at least) assumes the database tables for the `django.contrib.contenttypes` app
[are created in the same database as the instance being linked to](https://github.com/django/django/blob/stable/3.2.x/django/contrib/contenttypes/fields.py#L164-L165
). But creating a `django_content_types` table in multiple databases is explicitly warned against in the Django docs:

{{< figure src="/images/django-warning-about-multiple-databases.png" title="" caption="" alt="Django warning about multiple databases" >}}

Since generic foreign keys use a cascading database reference between the
table with the generic foreign key and the `django_content_types` table, it
would be dangerous to have a separate `django_content_types` table in another
database where the primary key is looked up.


