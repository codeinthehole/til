---
title: "That `head` and `HEAD` can resolve differently in added Git worktrees"
date: "2025-09-02T19:52:37+01:00"
tags: ["Git"]
summary: "The case of the ref matters in added Git worktrees"
---

To prepare for a live demo of agentic coding, I created two branches based off a
historic commit and checked each one out in a separate worktree.

```
default   ____a_b_________c_d
demo1         \
demo2         \
```

The idea was to recreate commit `b` using two LLM agents, one in each branch, to
compare their approach and output.

I did a dress rehearsal and it worked as expected with each agent adding a new
commit to their respective branches:

```
default   ____a_b_________c_d
demo1         \_x
demo2         \_y
```

To reset the branches for the live demo, I ran:

```sh
git reset --hard head^
```

on each demo branch to remove the just-created commits (`x` and `y`).

However, instead of reverting each demo branch to commit `a`, they were reset to
commit `c`, the second-to-last commit on the primary worktree:

```
default   ____a_b_________c_d
demo1                     \
demo2                     \
```

I didn't spot this and it ruined my demo. Why though?

The problem was I used (lowercase) `head` instead of `HEAD`.

On case-folding file systems (the default on MacOS), the `head` ref behaves
differently in an added Git worktree: it resolves to the tip of the _main
worktree_ rather than the current branch. Hence why I inadvertently reset each
demo branch to the wrong commit.

To avoid this problem, don't use `head` in added Git worktrees. Either use the
upper case `HEAD` or less dangerous `@` reference.

[This Stack Overflow answer](https://stackoverflow.com/a/62307256) explains it
well.
