---
title: "About Github's `involves:$username` search filter"
date: "2022-02-02T18:08:58+00:00"
tags: ["Github"]
---

There's a [plethora of filters][search_docs] that can be used with Github's
search functionality.

An interesting filter is [`involves:$username`][involves_docs] which selects
issues or pull requests where the user:

- Is the author
- Has commented
- Has been mentioned
- Has been assigned
- Has been requested as a reviewer

This can be useful to get an overview of a team's activity over some period. You
can use the `updated:>YYYY-DD-MM` filter to restrict the results to pull
requests with recent activity.

I discovered this when trying to find how to select pull requests authored by a
set of users. This isn't possible in the pull request search (URL path
`/pulls`); only the last author is used. But it is possible in the more general
search (URL path `/search`) which has a different display format.

This [Stack Overflow post][so_answer] contained the pertinent advice.

[search_docs]:
  https://docs.github.com/en/search-github/searching-on-github/searching-issues-and-pull-requests
[involves_docs]:
  https://docs.github.com/en/search-github/searching-on-github/searching-issues-and-pull-requests#search-by-a-user-thats-involved-in-an-issue-or-pull-request
[so_answer]:
  https://stackoverflow.com/questions/36433230/in-github-is-there-a-way-to-search-for-pull-requests-created-by-any-author-from
