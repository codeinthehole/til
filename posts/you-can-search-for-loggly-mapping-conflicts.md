---
title: "You can search for Loggly mapping conflicts"
date: "2022-02-10T11:01:19+00:00"
tags: ["Loggly"]
---

Loggly stores your JSON event data in a single ElasticSearch schema. As such,
you need to be careful about using consistent types within your JSON payloads.

For example, if you publish a field as a string in one event but an object in
another then you'll get a mapping conflict and the latter object won't be
indexed correctly.

You can find mapping conflicts by searching for
`LogglyNotifications.type:MappingConflict` then use the notifications data to
see which field has the problem.

It's hard to guard against this problem with static analysis in your codebase.
But you can fix problems rapidly by setting up a alert that trips when new
events match the above mapping conflict filter.


