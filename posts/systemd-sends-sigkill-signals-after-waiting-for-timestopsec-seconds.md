---
title: "systemd sends SIGKILL signals after waiting for `TimeoutStopSec` seconds"
date: "2021-03-12T15:28:38+00:00"
tags: ["systemd", "Linux"]
---

From [`man systemd.kill`](https://www.freedesktop.org/software/systemd/man/systemd.kill.html):

>  Processes will first be terminated via SIGTERM (unless the signal to send is
>  changed via KillSignal=). Optionally, this is immediately followed by a
>  SIGHUP (if enabled with SendSIGHUP=). If then, after a delay (configured via
>  the TimeoutStopSec= option), processes still remain, the termination request
>  is repeated with the SIGKILL signal (unless this is disabled via the
>  SendSIGKILL= option).

The default for `TimeoutStopSec` is 90 seconds. You can check how a particular
unit is configured with:

```bash
$ systemctl $UNIT_NAME check | grep Timeout
TimeoutStartUSec=infinity
TimeoutStopUSec=1min 30s
JobTimeoutUSec=infinity
JobRunningTimeoutUSec=infinity
JobTimeoutAction=none
```

If you don't want `systemd` to forcibly kill your process, you might consider
setting `TimeoutStopSec=infinity`.


