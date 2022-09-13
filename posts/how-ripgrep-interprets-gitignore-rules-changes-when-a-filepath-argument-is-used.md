---
title:
  "How Ripgrep interprets `.gitignore` rules changes when a filepath argument is
  used"
date: "2022-09-13T17:25:58+01:00"
tags: ["ripgrep"]
---

Consider this dummy static site structure:

```sh
$ mkdir -p docs/_build/
$ echo "<h1>hello</h1>" > docs/_build/index.html
$ echo "# hello" > docs/index.md
```

A Ripgrep search for "hello" matches both files:

```sh
$ rg hello
docs/index.md
1:# hello

docs/_build/index.html
1:<h1>hello</h1>
```

Suppose we want to ignore generated HTML files in `docs/_build/`. We could add
`docs/_build/` to a `.gitignore` file:

```sh
$ echo "docs/_build/" > .gitignore
```

and searches ignore that folder:

```sh
$ rg hello
docs/index.md
1:# hello
```

But explicitly searching the `docs` folder matches files that we want ignored:

```sh
$ rg hello docs/
docs/_build/index.html
1:<h1>hello</h1>

docs/index.md
1:# hello
```

From `man rg`:

> Paths specified explicitly on the command line override glob and ignore rules.

which, in practice, seems to mean that the `.gitignore` rules are applied
against filepaths _relative_ to the filepath argument.

So in the above example, we can get the behaviour we want by changing the
`.gitignore` rule to `**/_build`.

```sh
$ echo "**/_build/" > .gitignore
$ rg hello docs/
docs/index.md
1:# hello
```

For a deeper discussion, see
[this ticket](https://github.com/BurntSushi/ripgrep/issues/829).
