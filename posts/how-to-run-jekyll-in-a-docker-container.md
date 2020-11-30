---
title: "How to run Jekyll in a Docker container"
date: "2020-11-30T11:28:09+00:00"
tags: ["Jekyll", "Ruby", "Docker"]
---

To run the server, run:

```bash
docker run --rm \
    --volume="${PWD}:/srv/jekyll" \
    -p 4000:4000 \
    -it jekyll/jekyll:3.8 \
    jekyll serve --incremental
```

This will install your `Gemfile.lock` dependencies and run the local server on
port 4000.

If your Jekyll site is published using Github Pages, you can pin your `jekyll`
and `gh-pages` versions to [those used by Github](https://pages.github.com/versions/).
Having said that, [there is no v3.9.0 of `jekyll/jekyll` on the Docker Hub](https://hub.docker.com/r/jekyll/jekyll/tags?page=1&ordering=last_updated) so it's
best to use v3.8 for now.
