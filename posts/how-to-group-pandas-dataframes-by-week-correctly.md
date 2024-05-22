---
title: "How to group Pandas dataframes by week correctly"
date: "2024-05-22T15:36:20+01:00"
tags: ["Pandas", "Python"]
---

Consider this toy dataframe which defines some meal events over a few weeks:

```py
import pandas as pd

tz = "Europe/London"
data = {
    'eaten_at': [
        # -- Week 1 --
        pd.Timestamp('2024-04-07 20:00', tz=tz),  # Sunday
        # -- Week 2 --
        pd.Timestamp('2024-04-08 20:00', tz=tz),  # Monday
        pd.Timestamp('2024-04-09 20:00', tz=tz),  # Tuesday
        pd.Timestamp('2024-04-10 20:00', tz=tz),  # Wednesday
        pd.Timestamp('2024-04-11 20:00', tz=tz),  # Thursday
        pd.Timestamp('2024-04-14 20:00', tz=tz),  # Sunday
        # -- Week 3 --
        pd.Timestamp('2024-04-15 20:00', tz=tz),  # Monday
    ],
    'food': [
        'bacon',
        'eggs',
        'chips',
        'peas',
        'beans',
        'pizza',
        'curry'
    ]
}
df = pd.DataFrame(data)
```

I want to:

- Count the number of meals eaten each week (where a week is Monday to Sunday).
- Use the datetime of the start of the week (i.e. Monday) as the group label.

The result _should_ be:

```txt
eaten_at
2024-04-01 00:00:00+01:00    1
2024-04-08 00:00:00+01:00    5
2024-04-15 00:00:00+01:00    1
```

### Incorrect attempt 1

Use `freq="W-MON"`:

```py
df.groupby(
    by=pd.Grouper(key="eaten_at", freq="W-MON", label="left")
)["food"].count()
```

which gives:

```txt
eaten_at
2024-04-01 00:00:00+01:00    2
2024-04-08 00:00:00+01:00    5
```

which is grouping over a Tuesday-to-Monday week (❌), using the start of the
preceding Monday as the label (✅).

### Incorrect attempt 2

Use `freq="W-SUN"`:

```py
df.groupby(
    by=pd.Grouper(key="eaten_at", freq="W-SUN", label="left")
)["food"].count()
```

which gives:

```txt
eaten_at
2024-03-31 00:00:00+00:00    1
2024-04-07 00:00:00+01:00    5
2024-04-14 00:00:00+01:00    1
```

which is grouping over a Monday-to-Sunday week (✅) but the labels are from the
start of the preceding Sunday (❌).

### Correct solution

Use `freq="W-MON"` and also pass `closed="left"`:

```py
df.groupby(
    by=pd.Grouper(key="eaten_at", freq="W-MON", label="left", closed="left")
)["food"].count()
```

which gives the desired:

```txt
eaten_at
2024-04-01 00:00:00+01:00    1
2024-04-08 00:00:00+01:00    5
2024-04-15 00:00:00+01:00    1
```

When `freq` is passed to `pd.Grouper`, both `closed` and `label` default to
`"right"` and so the `W-MON` frequency is interpreted as Tuesday-to-Monday (as
it includes the end day inclusively).

Similarly `W-SUN` (with `closed="right"`) is interpreted as Monday-to-Sunday,
the period we want, but it uses the start of the preceding Sunday as its label
(as Sunday is the exclusive start date of the period).

Using `closed="left"` with `freq="W-MON"` is correct as it ensures the period is
Monday-to-Sunday and the starting Monday is included in the period, hence the
label is the start of the week.

### Conclusion

Trying to group a datetime field by a Monday-to-Sunday week is quite
counter-intuitive.

Further reading:

- There's a useful explanation of this in [this Stack Overflow][so_link] answer.

- See also the [`pandas.Grouper` docs][grouper_link].

[so_link]: https://stackoverflow.com/a/66772221
[grouper_link]: https://pandas.pydata.org/docs/reference/api/pandas.Grouper.html
