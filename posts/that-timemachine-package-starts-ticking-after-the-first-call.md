---
title: "That `time_machine` starts ticking after the first call"
date: "2024-06-05T19:33:09+01:00"
tags: ["Testing", "Python"]
summary: "Not after the context manager is entered, as you might expect."
---

I was surprised to learn today that this test passes:

<!--more-->

```py
import time_machine
import datetime

def test_ticking_behaviour():
    with time_machine.travel("2020-06-10T14:00:00", tick=True):
        # Let some time pass.
        time.sleep(1)
        # Time should now be around 14:00:01, right? Wrong!
        assert datetime.datetime.now() == datetime.datetime(2020, 6, 10, 14, 0, 0)
```

This is because `time_machine.travel` starts ticking after the _first call to
the system clock_, not from when the context manager is entered. This [is
documented][time_machine_travel] but is quite counter intuitive.

## Antipattern: using `time_machine` to set `auto_now_add=True` Django field values

I stumbled upon this when debugging a failing test. The test was using
`time_machine` to specify a value for a Django model field declared with
`auto_now_add=True`. Something like this:

```py
import time_machine
import datetime

# Import some factory-boy factory classes.
from . import factories

def test_frob_creation():
    with time_machine.travel("2020-06-10T14:00:00"):
        # Frob's have a `created_at` field declared with `auto_now_add=True`.
        # Since this is the first system clock call in this `time_machine`
        # block, the `created_at` field will be set to *exactly* the above time.
        frob = factories.FrobFactory()

    assert frob.created_at == datetime.datetime(2020, 6, 10, 14, 0, 0)
```

This test was passing until I wrapped one of the `FrobFactory` fields with
`factory.LazyFunction` to ensure the system clock was only called during test
execution time (not test collection). This caused the test to fail as (the
equivalent of) `frob.created_at` now had a microsecond component.

This was because the first system clock call was now in computing a factory
field value, and hence some time had ticked by before the model was saved (and
the `created_at` value computed).

I wouldn't recommend using `time_machine` to set `auto_now_add=True` fields in
this way — it's better to pass them inexplicitly. But, if you do, ensure you
pass `tick=False` to avoid this problem.

<!--links-->

[time_machine_travel]:
  https://github.com/adamchainz/time-machine?tab=readme-ov-file#traveldestination--ticktrue
