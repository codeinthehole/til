---
title: "Javascript's unary `+` operator casts `null` to zero"
date: "2020-09-21T10:24:01+01:00"
tags: ["Javascript"]
---

As in:

```js
> +null
0
```

which is different from `parseInt` or `parseFloat` which return `NaN` when given
`null`.
