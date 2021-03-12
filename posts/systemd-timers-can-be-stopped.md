---
title: "systemd timers can be stopped"
date: "2021-03-09T13:54:04+00:00"
tags: ["systemd", "Linux", "APT"]
---

Timers are systemd unit files that control services. I didn't realise until
today that, when disabling a timer, it also needs to be stopped too. This can be
done with the `--now` option:

```bash
$ systemctl disable --now apt-daily.timer
```

Before this, running:

```bash
$ systemctl disable apt-daily.timer
$ systemctl stop apt-daily.service
```

didn't guarantee that the `apt-daily` service had stopped, which caused
intermittent lock acquisition problems when provisioning.

