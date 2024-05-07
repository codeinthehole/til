---
title: "Hugo v0.123.0 changed the default rendering mode of `hugo server`"
date: "2024-05-07T10:37:10+01:00"
tags: ["Hugo"]
---

## The problem

After running `brew upgrade` and upgrading Hugo from v0.121.1 to v0.125.4, I
found that `hugo server` was rewriting all the permalinks in my site to use
`localhost:1313`. These changes would persist after `hugo server` was stopped
and I accidentally committed them and broke the production version of this site.

## The cause

Hugo [v1.123.0][hugo_v0.123.0] shipped a number of breaking changes, including
changing the default render mode of `hugo server` from `--renderToMemory` to
`--renderToDisk` ([issue #11987][hugo_change_render_issue]).

Hence running `hugo server` locally would modify my production build on disk,
using `localhost:1313` as the base URL instead of the configured `baseURL` from
`hugo.toml`.

## The fix

Specify `--renderToMemory` flag when running `hugo server` locally.

## Also

It was tricky to determine what version of Hugo I had installed before running
`brew upgrade`. I eventually found it in the Hugo HTML metadata. Not sure if
there a method that works for any package.

[hugo_change_render_issue]: https://github.com/gohugoio/hugo/issues/11987
[hugo_v0.123.0]: https://github.com/gohugoio/hugo/releases/tag/v0.123.0
