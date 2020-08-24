---
title: "You can rate-limit issues using a Sentry DSN"
date: "2020-08-24T16:19:10+01:00"
tags: ["Sentry"]
---

If you want to manage how your event quota is consumed with Sentry, you can
apply rate limits at the DSN level. 

{{< figure src="/images/sentry-dsn-editing.png" title="" caption="" alt="Sentry DSN editing" >}}

This lets you apply different rate limiting settings for different parts of your
application by using separate DSNs.

See [Sentry's docs](https://docs.sentry.io/accounts/quotas/manage-event-stream-guide/#6-rate-limiting)
on the subject.


