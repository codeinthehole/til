---
title: "How to profile Pytest tests"
date: "2022-06-23T10:36:09+01:00"
tags: ["Testing", "Pytest", "Profiling"]
---

If you install the [`pytest-monitor`](https://pytest-monitor.readthedocs.io/)
package, then PyTest invocations will collect test profiling information in a
SQLite database (called `.pymon` by default).

The schema includes a `TEST_METRICS` table that has columns for:

- Time spent running the test (in seconds);
- CPU usage percentage;
- Maximum resident memory during test execution (in megabytes).

More details in the
[schema definition](https://pytest-monitor.readthedocs.io/en/latest/operating.html#execution-context-metrics-and-session).

You can query these metrics from the CLI like so:

```sh
QUERY="SELECT ITEM_PATH, ITEM_VARIANT, TOTAL_TIME, MEM_USAGE FROM TEST_METRICS"
sqlite3 -column .pymon "$QUERY"
```

To house the data in a spreadsheet for sharing, format them as a tab-separated
list which can be pasted in:

```sh
sqlite3 -noheader -csv -separator $'\t' .pymon "$QUERY" | pbcopy
```
