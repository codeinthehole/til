---
title: "How to get Vale to work with Vim's Ale plugin"
date: "2022-02-20T18:54:33+00:00"
tags: ["Vale", "Vim"]
---

[Vale][vale] is an extensible syntax aware linter. It can integrate with Vim via
[Ale][ale] although there's a gotcha to be aware of.

Vale's config file uses globs to determine which formats to apply. E.g.

```ini
[posts/*.md]
BasedOnStyles = Vale, write-good, proselint
```

However, by default, Ale lint files by running each linter on a temporary copy
of the file which has a different path. This means the above glob doesn't match
and Vale finds no errors.

To work around this, it's best to avoid folders your `.vale.ini` globs:

```ini
[*.md]
BasedOnStyles = Vale, write-good, proselint
```

as this will match temporary files (that still have a `.md` extension).

Further reading:

- There's a bit more discussion on [this Github ticket][gh_ticket].
- The `:ALEInfo` command is very useful for debugging why Ale isn't doing what
  you expect it to.

[vale]: https://github.com/errata-ai/vale
[ale]: https://github.com/dense-analysis/ale
[gh_ticket]: https://github.com/dense-analysis/ale/issues/3363
