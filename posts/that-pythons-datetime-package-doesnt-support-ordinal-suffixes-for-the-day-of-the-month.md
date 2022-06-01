---
title: "That Python's `datetime` package doesn't support ordinal suffixes for the day of the month"
date: "2022-06-01T16:29:28+01:00"
tags: ["Python", "Django"]
---

[Django's `date` template filter][django_date] (and underlying
[`django.utils.dateformat`][django_dateformat] module) support using `S` as a
format character for the English ordinal suffix for the day of the month.

{{< figure src="/images/djangodatecodes.png" title="" caption="" alt="django-date-codes" >}}


As in:
```html+django
{{ value|date:"jS F Y" }}
```
will render as something like:
```
2nd June 2022
```

However the `S` format character is not supported by the [`strftime` and
`strptime` functions of the standard library][format_codes]. 

This is true of other languages too. Ordinal suffixes are not supported
by the standard libraries of Golang, Java, Rust or Ruby either.

They _are_ supported by PHP's `date` function though. Indeed, this was the
motivation for Django's implementation.

{{< figure src="/images/djangodateformat.png" title="" caption="" alt="django-date-format" >}}

[django_date]: https://docs.djangoproject.com/en/4.0/ref/templates/builtins/#date
[django_dateformat]: https://github.com/django/django/blob/main/django/utils/dateformat.py
[format_codes]: https://docs.python.org/3/library/datetime.html#strftime-and-strptime-format-codes
[php_date]: https://www.php.net/manual/en/function.date.php
[php_format_codes]: https://www.php.net/manual/en/datetime.format.php

