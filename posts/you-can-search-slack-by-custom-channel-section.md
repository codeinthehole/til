---
title: "You can search Slack by custom channel section"
date: "2023-06-05T13:42:03+01:00"
tags: ["Slack"]
---

Slack provides an [`in:` search modifier][slack_search] to narrow the scope of
results to a given channel. Further, multiple `in:` modifiers will filter
results to a set of channels.

The problem I was trying to solve was to search within a large set of channels;
too many to bother typing into a single search query.

All the channel names followed a pattern so I was hoping I could use a wildcard
filter like `in:tech-guild-*` but alas no.

However it turns out the `in:` modifier can act on a custom channel section, and
I happened to have a "Tech Guilds" section including all the relevant channels.
So `in:Tech Guilds` was the filter I needed.

[slack_search]:
  https://slack.com/intl/en-gb/help/articles/202528808-Search-in-Slack
