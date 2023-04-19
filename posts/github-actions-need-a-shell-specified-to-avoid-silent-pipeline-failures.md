---
title: "Github actions need a shell specified to avoid silent pipeline failures"
date: "2023-04-19T21:12:02+01:00"
tags: ["Github actions"]
---

I learnt the hard way that the default shell settings for Github actions don't
catch command pipeline failures.

That is, this workflow does not fail:

```yaml
---
name: Pipeline SILENT failure

jobs:
  my-silently-failing-job:
    runs-on: ubuntu-latest
    steps:
      - name: Pipeline fail
        run: false | true
```

In my case, I was doing something like:

```sh
python main.py $args | tee output.txt
```

and didn't realise that the Python command was crashing as the pipeline exit
code was zero.

The solution is to specify `shell: bash` which [causes Github to run the command
with `set -eo pipefail`][gh_actions] and hence pipeline failures are caught.

This workflow will fail:

```yaml
---
name: Pipeline NOISY failure

jobs:
  my-failing-job:
    runs-on: ubuntu-latest
    steps:
      - name: Pipeline fail
        shell: bash
        run: false | true
```

[gh_actions]:
  https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#exit-codes-and-error-action-preference
