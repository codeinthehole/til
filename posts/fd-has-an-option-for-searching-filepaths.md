---
title: "`fd` has an option for searching filepaths"
date: "2020-10-23T17:35:10+01:00"
tags: ["Command-line tools", "fd"]
---

If you pass `-p`, then the [`fd`](https://github.com/sharkdp/fd) will retrieve all filepaths matching `$PATTERN`:

```bash
$ fd -p epex
tests/fixtures/epex
tests/fixtures/epex/hourly.csv
tests/fixtures/epex/half_hourly.csv
tests/unit/common/vendors/epex
tests/unit/common/vendors/epex/__init__.py
tests/unit/common/vendors/epex/test_parsers.py
octoenergy/vendors/epex
octoenergy/vendors/epex/__init__.py
octoenergy/vendors/epex/parsers.py
```

Very useful.
