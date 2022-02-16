---
title: "To prefer `dateutil` over `pytz`"
date: "2021-03-04T16:09:11+00:00"
tags: ["Python", "Timezones"]
---

When constructing `datetime.datetime` instances, it's better to use `dateutil`
to provide the `tzinfo` argument — avoid using `pytz`.

That is, prefer this:

```py
import datetime
from dateutil import tz

tzinfo = tz.gettz("Europe/London")
datetime.datetime(2021, 10, 30, 12, 0, tzinfo=tzinfo)
```

to

```py
import datetime
import pytz

tzinfo = pytz.timezone("Europe/London")
datetime.datetime(2021, 10, 30, 12, 0, tzinfo=tzinfo)
```

Why? Because passing `pytz`'s timezones to the `datetime.datetime` constructor
can often lead to bugs after date arithmetic (i.e. computing new dates using
`datetime.timedelta`). This is noted in the
[`pytz` docs](https://pythonhosted.org/pytz/):

{{< figure src="/images/pytz-docs.png" title="" caption="" alt="pytz docs" >}}

It's easy to be lulled into a false sense of security as such bugs don't affect
timezones without daylight savings transitions, like UTC.

See
[`pytz`: The Fastest Footgun in the West](https://blog.ganssle.io/articles/2018/03/pytz-fastest-footgun.html)
for more details.
