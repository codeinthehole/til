---
title:
  "Django's JSON encoder rounds `datetime`s down to the nearest millisecond"
date: "2022-12-01T11:46:25+00:00"
tags: ["Django", "JSON"]
---

Django provides [a custom `DjangoJSONEncoder` class][django_docs] that can
encode `datetime.date`, `datetime.datetime`, `decimal.Decimal` and `uuid.UUID`
types.

Beware though: this class serializes `datetime.datetime` instances to
_millisecond_ precision only. Since Python's `datetime.datetime` type supports
_microsecond_ precision, the serialisation process can change the datetime's
value.

Watch:

```py
>>> import datetime
>>> import json
>>> from django.core.serializers.json import DjangoJSONEncoder
>>>
>>> # Create a datetime with sub-millisecond precision.
>>> dt = datetime.datetime(2022, 12, 1, 14, 0, 0, 1234)
>>> dt.isoformat()
"2022-12-01T14:00:00.001234"
>>>
>>> # Serialize the datetime using Django's encoder.
>>> print(json.dumps(dt, cls=DjangoJSONEncoder))
"2022-12-01T14:00:00.001"
```

As the above snippet illustrates, serialising a `datetime.datetime` effectively
rounds it down to the nearest millisecond.

## Why?

This [rounding is deliberate][django_serialize].

{{< figure src="/images/django-json-encoder.png" title="" caption="" alt="django JSON encoder" >}}

It's done to ensure serialized `datetime` strings conform with the [ECMAScript
262 language specification][ecma_262] which mandates millisecond precision.
Ultimately, this is because the [JavaScript `Date`][js_date] object only
supports millisecond precision.

## Broken tests

This is a gotcha that can effect tests that compare `datetime` values that get
serialized and deserialized (which is how I stumbled upon it).

If you need to perform the same rounding in Python code, use something like:

```py
rounded_dt = dt.replace(microsecond=dt.microsecond // 1000 * 1000)
```

[django_docs]:
  https://docs.djangoproject.com/en/4.1/topics/serialization/#djangojsonencoder
[django_serialize]:
  https://github.com/django/django/blob/149b55fefad03c18589d580ef53d41e7c99408ed/django/core/serializers/json.py#L84-L88
[ecma_262]: https://262.ecma-international.org/5.1/#sec-15.9.1.15
[js_date]:
  https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date
