---
title: "Email Log Search in Google Workspace has some strange behaviour"
date: "2022-07-20T15:20:35+01:00"
tags: ["G-Suite"]
---

Google Workspace admins can use the [Email Log Search][email_logs] feature to
inspect emails sent and received by Gmail. However beware that the email detail
page isn't consistent: it can change depending on which filters were used to
find it.

If you filter by sender email address, the email detail page shows the correct
recipients (including those added by Gmail's default routing rules).

However if you filter by recipient, the email detail page is the same except the
additional recipients aren't shown.

This is quite confusing.

There is a note in the docs that describes something similar:

{{< figure src="/images/google-email-logs-note.png" title="" caption="" alt="Google Email Logs note" >}}

Ultimately, if you're debugging routing rules then always search using the
sender address, not the recipient.

[email_logs]: https://support.google.com/a/answer/2618874?hl=en
