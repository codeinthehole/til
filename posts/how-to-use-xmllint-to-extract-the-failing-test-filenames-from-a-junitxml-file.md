---
title:
  "How to use `xmllint` to extract the failing test filenames from a JUnit-XML
  file"
date: "2022-06-28T12:25:07+01:00"
tags: ["Pytest", "Testing"]
---

Pytest will generate a [JUnit-XML][junit_spec] result report when run with [the
`--junitxml` option][pytest_junitxml].

To extract the names the files containing failing tests, this
[`xmllint`][xmllint] command can be used:

```sh
xmllint --xpath '//testcase[.//failure]/@file' results.xml | \
    tr " " "\n" | awk 'BEGIN { FS="\"" } { print $2 }' | \
    sort | uniq
```

Here we:

- Use an [XPath][xpath] filter to select all `file` attributes from `<testcase>`
  elements containing a `<failure>` child element.

- Use `tr` and `awk` to convert the output into a list of filenames.

- Use `sort` and `uniq` to print a list of unique filenames.

This is a little convoluted. XMLLint doesn't support using a `string` XPath
function to print the attribute values of all matches (it only prints the first
one) which is why we need to pipe out to standard Unix tools.

[pytest_junitxml]:
  https://docs.pytest.org/en/latest/how-to/output.html#creating-junitxml-format-files
[junit_spec]:
  https://github.com/jenkinsci/xunit-plugin/blob/master/src/main/resources/org/jenkinsci/plugins/xunit/types/model/xsd/junit-10.xsd
[xpath]: https://www.w3.org/TR/1999/REC-xpath-19991116/
[xmllint]:
  https://www.w3.org/TR/1999/REC-xpath-19991116://gnome.pages.gitlab.gnome.org/libxml2/xmllint.html
