---
title: "About Factory Boy's `SelfAttribute` class"
date: "2022-02-16T09:17:38+00:00"
tags: ["FactoryBoy", "Testing", "Python"]
---

Factory Boy has a useful [`SelfAttribute`][docs] class that lets a field
reference another field of the object being constructed.

It's particularly useful when used in a `SubFactory` as it lets you reference
fields on the parent object. E.g.

```py
import factory
from django.utils import timezone

class Message(factory.Factory):
    sent_at = factory.LazyFunction(timezone.now)


class Event(factory.Factory):
    occurred_at = factory.LazyFunction(timezone.now)

    message = factory.SubFactory(
        Message,
        # Ensure the sent_at of the linked message matches the occurred_at field
        # of the event.
        sent_at=factory.SelfAttribute("..occurred_at")
    )

event = Event()
assert event.occurred_at == event.message.sent_at  # True
```

[docs]: https://factoryboy.readthedocs.io/en/stable/reference.html#selfattribute
