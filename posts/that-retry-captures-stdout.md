---
title: "That Ubuntu's `retry` command captures STDOUT"
date: "2022-08-18T15:00:40+01:00"
tags: ["Ubuntu"]
---

Debian's [`retry`][debian_manpage] command allows you to repeatedly run a
command until it succeeds. This is useful for running commands that
intermittently fail.

Example usage:

```sh
retry --until=success --times=3 $FLAKEY_CMD
```

But we discovered the hard way today that it captures the wrapped command's
STDOUT until the command exits, which can be a problem in environments where
commands are killed after a period of no output. This happens in CircleCI.

To be fair, this is noted in [the command's help text][github_help_source]:

> Retry captures stdout into memory, and if the command was successful stdout is
> passed on to stdout as normal, while if the command was repeated stdout is
> passed to stderr instead. This ensures that output is passed to stdout once
> and once only.

The solution in our case was to extend Circle's timeout [using the
`no_output_timeout` parameter][circleci_timeout].

[debian_manpage]: https://manpages.debian.org/testing/retry/retry.1.en.html
[github_help_source]:
  https://github.com/minfrin/retry/blob/f6f1acd4b235e96dd9cb11263fb181ec44c3ece9/retry.c#L108-L111
[circleci_timeout]:
  https://support.circleci.com/hc/en-us/articles/360045268074-Build-Fails-with-Too-long-with-no-output-exceeded-10m0s-context-deadline-exceeded-
