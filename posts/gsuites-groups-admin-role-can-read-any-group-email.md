---
title: "GSuite's \"Groups Admin\" role can read any group email"
date: "2020-12-02T11:39:41+00:00"
tags: ["G-Suite"]
---

If members of your Google org want to administer groups, it's tempting to
make them a "Groups Admin".

{{< figure src="/images/gsuite-groups-admin.png" title="" caption="" alt="G-Suite Groups Admin" >}}

Be careful though as this allows the person to read _any_ message sent to _any_ group
(including historical messages), and most organisations have groups whose
messages contain sensitive information (e.g. HR or payroll).

A Groups Admin can browse group messages by visiting the appropriate conversation page:

```
https://groups.google.com/a/$ORG_DOMAIN/g/$GROUP_NAME
```

A Groups Admin has access to such pages even if they aren't an
owner/manager/member of the group.
