---
title: "How to spell-check markdown repos on CircleCI"
date: "2020-12-07T11:34:05+00:00"
tags: ["Markdown", "CircleCI"]
---

The [`tmaier/markdown-spellcheck`](https://hub.docker.com/r/tmaier/markdown-spellcheck) Docker image
wraps [`node-markdown-spellcheck`](https://github.com/lukeapage/node-markdown-spellcheck) and can be used locally and on CircleCI to
spell-check markdown files.

Locally, run:

```bash
$ docker run --rm -ti -v $(pwd):/workdir tmaier/markdown-spellcheck:latest \
    --report --ignore-numbers --ignore-acronyms "**/*.md"
```

In your `.circleci/config.yml` file, use:

```yaml
version: 2.1

jobs:

  spelling:
    docker:
      - image: tmaier/markdown-spellcheck:latest
    steps:
      - checkout
      - run:
          name: Check spelling
          command: mdspell --report --ignore-numbers --ignore-acronyms "**/*.md"

workflows:
  static-analysis:
    jobs:
      - spelling
```

Thanks to [Luke Page](https://github.com/lukeapage) for the node library and [Tobias L. Maier](https://tobiasmaier.info/) for the Docker wrapper.
