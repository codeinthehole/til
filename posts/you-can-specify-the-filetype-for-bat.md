---
title: "You can specify the file-type for `bat`"
date: "2020-12-21T10:33:25+00:00"
tags: ["Command-line tools", "Helm"]
---

[`bat`](https://github.com/sharkdp/bat) is a useful replacement for `cat` that
supports syntax highlighting.

`bat` can auto-detect file-types but, for cases when it can't, you can use the
`-l, --language` option. This is useful for syntax-highlighting the output of
commands. For example, the output of `helm install --dry-run` which prints the
contents of the compiled YAML files:

```bash
$ helm install --dry-run --generate-name . | cat -l yaml
```

