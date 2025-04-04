---
title: "When to use stdout and stderr in shell scripts"
date: "2025-03-19T09:42:43+00:00"
tags: ["Bash"]
summary: "Write `--help` output to stdout"
---

I recently gained a deeper understanding of when to use stdout and stderr in
shell scripts. The [definitions in Wikipedia][wiki_standard_streams] are:

<!--more-->

_Standard output (stdout)_:

> Standard output is a stream to which a program writes its output data.

_Standard error (stderr)_:

> Standard error is another output stream typically used by programs to output
> error messages or diagnostics. It is a stream independent of standard output
> and can be redirected separately.

I had been following these guidelines but was missing some subtleties.

## Write `--help` output to stdout

When you run:

```sh
> $command --help
```

you're explicitly asking for help so the output should be written to stdout; the
help output is the data.

This is documented in the [GNU coding standards][gnu_help] and discussed in
[this Hacker News thread][hn_help].

However, if you include the `--help` content or usage instructions in an error
message, then it should be written to stderr. E.g. if you run:

```sh
> $command --bad-option
```

then the error message should be written to stderr instead.

[hn_help]: https://news.ycombinator.com/item?id=37682859
[gnu_help]: https://www.gnu.org/prep/standards/html_node/_002d_002dhelp.html
[wiki_standard_streams]: https://en.wikipedia.org/wiki/Standard_streams
