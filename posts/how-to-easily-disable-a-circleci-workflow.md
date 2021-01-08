---
title: "How to easily disable a CircleCI workflow"
date: "2021-01-08T12:32:30+00:00"
tags: ["CircleCI", "Testing"]
---

Sometimes it's useful to only run a subset of CircleCI jobs after each commit to
a pull request branch. For instance, if you're working on packaging step of your
test-package-deploy pipeline, it's helpful to create a faster feedback loop by
only running the packaging jobs after each push.

This can be done by adding a temporary commit that disables the main workflow
and adds a custom one running only the jobs you care about.

You can disable a CircleCI workflow using the `when` attribute:

```yaml
# .circleci/config.yml

version: 2.1

workflows:

    # Define a custom workflow that only runs the jobs you're interested in.
    temp_workflow:
        - build_job_1
        - build_job_2

    # The standard (but slow) workflow that normally runs on each push.
    test_build_deploy;
        # Temporarily disable this workflow
        when: false

        ...
```

Make sure you rebase out this commit before requesting review or merging the
pull request; it's just a crutch to speed up development.

See CircleCI's docs on [using `when` in workflows](https://circleci.com/docs/2.0/configuration-reference/#using-when-in-workflows).
