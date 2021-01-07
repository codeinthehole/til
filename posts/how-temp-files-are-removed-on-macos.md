---
title: "How temporary files are removed on MacOS"
date: "2021-01-07T10:51:08+00:00"
tags: ["MacOS"]
---

On MacOS, temporary files are stored in either `/tmp/` or a per-user temporary
folder specified by the `$TMPDIR` environment variable; this is normally a
subfolder of `/var/folders/`.

Temporary files are periodically removed by the `com.apple.periodic-daily`
launch daemon (specified in `/System/Library/LaunchDaemons/com.apple.periodic-daily.plist`). This runs
the `/usr/sbin/periodic` shell script (via `/usr/libexec/periodic-wrapper`).
This runs all scripts in `/etc/periodic/daily/` including
`/etc/periodic/daily/110.clean-tmps` which is responsible for removing old temporary files.
The default configuration `/etc/defaults/periodic.conf` ensures any files
in `/tmp` that haven't been accessed for 3 days are deleted.

```
# /etc/defaults/periodic.conf

...
# 110.clean-tmps
daily_clean_tmps_enable="YES"      # Delete stuff daily
daily_clean_tmps_dirs="/tmp"       # Delete under here
daily_clean_tmps_days="3"          # If not accessed for
...
```

Output from this job is logged in `/var/log/daily.out`.

It's hard to determine exactly how stale files in `$TMPDIR` are removed. The
folder appears to be flushed when a machine reboots but I can't tell if they are
periodically removed as well.

This is accurate as of MacOS 10.15.7

Sources:

- [Stack Overflow: "In MacOS, how often is `/tmp` deleted?"](https://superuser.com/a/187105)
- [What is `/var/folders`?](http://www.magnusviri.com/what-is-var-folders.html)
- [`periodic-wrapper` man page](https://www.unix.com/man-page/osx/8/periodic-wrapper)

