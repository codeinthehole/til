---
title: "You can use `shuf` to take random samples of lines"
date: "2021-04-14T12:09:31+01:00"
tags: ["Unix"]
---

For example, I wanted to share a random sample of accounts affected by some
issue based on a Loggly event export. This can be done with:

```sh
$ cat loggly_events.json | jq -r '.events[].event.json.account' | shuf -n20
```

More info in [this short `shuf` tutorial](https://shapeshed.com/unix-shuf/).



