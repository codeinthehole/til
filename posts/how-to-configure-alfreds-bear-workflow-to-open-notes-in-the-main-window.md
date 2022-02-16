---
title:
  "How to configure Alfred's Bear workflow to open notes in the main window"
date: "2020-09-02T11:34:04+01:00"
tags: ["Alfred", "Bear"]
---

This applies to the
[Bear workflow written in Go](https://github.com/drgrib/alfred-bear) whose
default behaviour (in v1.1.6) is to open notes in a new window rather than the
main Bear application window.

To adjust this, after installing and performing
[the dance of authorising all the workflow scripts](https://github.com/drgrib/alfred-bear#authorization),
you need to manually edit the workflow property list file and replace
`new_window=yes` with `new_window=no`.

FYI: the `info.plist` file can be found in:

```text
~/Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/
```

or by right clicking on the workflow in Alfred's preferences and selecting "Open
in Finder".
