---
title: "That Mypy can generate coverage reports"
date: "2024-05-04T14:29:31+01:00"
tags: ["Mypy", "Python", "Coverage"]
---

Mypy has options for generating coverage reports. From the `--help` output:

```txt
Report generation:
  Generate a report in the specified format.

  --any-exprs-report DIR
  --cobertura-xml-report DIR
  --html-report DIR
  --linecount-report DIR
  --linecoverage-report DIR
  --lineprecision-report DIR
  --txt-report DIR
  --xml-report DIR
  --xslt-html-report DIR
  --xslt-txt-report DIR
```

The HTML report looks something like this:

{{< figure src="/images/mypy-coverage-home.png" link="/images/mypy-coverage-home.png" title="" caption="" alt="mypy coverage home" >}}

and:

{{< figure src="/images/mypy-coverage-detail.png" link="/images/mypy-coverage-detail.png" title="" caption="" alt="mypy coverage detail" >}}
