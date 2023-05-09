---
title: "That `git for-each-ref` support conditional logic in its format"
date: "2023-04-28T20:11:32+01:00"
tags: ["Git"]
---

Git's [`for-each-ref`][foreachref] command allows you to iterate over refs and
print them according to the `--format` option.

The format options are different to those for `git log`. In particular, they
allow conditional logic using [`%(if)%(then)%(else)%(end)`][ifthenelse] syntax.

Here's some example usage where we print your local branches in different
colours depending on whether they have an upstream tracking branch.

```sh
git branch --format='%(if)%(upstream)%(then)%(else)%(color:dim)%(end)%(refname:short)%(color:reset)'
```

Hat-tip to [Sam Searles-Bryant][sam] for this tip.

[foreachref]: https://git-scm.com/docs/git-for-each-ref
[ifthenelse]:
  https://git-scm.com/docs/git-for-each-ref#Documentation/git-for-each-ref.txt-if
[sam]: https://samueljsb.co.uk/
