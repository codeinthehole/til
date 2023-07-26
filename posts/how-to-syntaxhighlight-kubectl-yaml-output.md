---
title: "How to syntax-highlight kubectl YAML output"
date: "2023-07-26T09:48:58+01:00"
tags: ["Kubernetes", "Bat"]
---

By default, the output of:

```sh
kubectl describe pod $POD_ID
```

is a hard-to-read YAML blob. To make it more readable, pipe it through `bat`:

```sh
kubectl describe pod $POD_ID | bat -l yaml
```

The `-l` option tells `bat` which language to use to highlight the context piped
into STDIN.
