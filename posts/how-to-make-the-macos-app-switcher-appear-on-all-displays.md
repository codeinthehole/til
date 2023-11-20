---
title: "How to make the MacOS app switcher appear on all displays"
date: "2023-11-20T12:44:04+00:00"
tags: ["MacOS"]
---

If you have multiple displays connected to your Mac, you may have noticed that
the app switcher (`cmd+tab`) only appears on the display where the Dock is
located. This is mildly annoying if you happen to be looking at the other
display.

But it's possible to have the app switcher appear on all displays, so it's
always visible in the display you're looking at:

```bash
defaults write com.apple.dock appswitcher-all-displays -bool true
```

You'll need to restart the Docker for this change to be picked up:

```bash
killall Dock
```

Found this tip on [this StackOverflow answer][so_answer].

[so_answer]:
  https://superuser.com/questions/670252/cmdtab-app-switcher-is-on-the-wrong-monitor
