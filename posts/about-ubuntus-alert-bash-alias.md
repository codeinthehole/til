---
title: "About Ubuntu's `alert` Bash alias"
date: "2021-05-14T14:28:19+01:00"
tags: ["Ubuntu", "Bash", "Linux"]
---

[Ubuntu's default `~/.bashrc`][bashrc] includes an `alert` alias for triggering
desktop notifications when long-running processes have completed:

```bash
alias alert='notify-send
    --urgency=low
    -i "$([ $? = 0 ] && echo terminal || echo error)"
    "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
```
(Wrapped for clarity).

Example usage:

```bash
$ ./run_test_suite.sh ; alert
```

It uses the exit code of the previous process `$?` to determine the message and
icon displayed. As you can see, it uses [`notify-send`](notifysend) to create the alert — [here's an explanation of how it works](explanation).

You can create a macOS equivalent with the Homebrew-installed [`terminal-notifier`][terminalnotifier]:

```bash
alias alert='terminal-notifier
    -title "Process finished"
    -message "$([ $? = 0 ] && echo Success || echo Error)"'
```

This is a basic version. You can make use of `terminal-notifier`'s options to
add sounds, icons and even activate iTerm2 again (with `-activate com.googlecode.iterm2`).

The appearance of the `terminal-notifier` notifications can be configured in
`System Preferences > Notifications`:

{{< figure src="/images/terminalnotifier-preferences.png" title="" caption="" alt="terminal-notifier preferences" >}}


[bashrc]: https://gist.github.com/marioBonales/1637696#file-bashrc-L85-L87
[explanation]: https://saddlebackcss.github.io/tutorials/bash/2016/01/20/how-bash-alert-works
[notifysend]: https://ss64.com/bash/notify-send.html
[terminalnotifier]: https://formulae.brew.sh/formula/terminal-notifier
