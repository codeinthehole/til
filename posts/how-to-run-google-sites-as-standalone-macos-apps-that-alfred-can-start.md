---
title: "How to run Google sites as standalone MacOS apps that Alfred can start"
date: "2023-09-22T10:20:58+01:00"
tags: ["Google", "Alfred", "MacOS"]
---

Many Google sites such as Meet, Drive and Youtube can be run as [Progressive Web
Apps (PWAs)][google_pwa], which means they run in their own Chrome application
and are treated as separate apps in MacOS.

{{< figure src="/images/google-meet-pwa.png" link="/images/google-meet-pwa.png" alt="Google Meet PWA." >}}

You can `cmd+tab` to switch to them and open them with Alfred.

{{< figure src="/images/alfred-google-meet.png" link="/images/alfred-google-meet.png" alt="Starting Google Meet from Alfred." >}}

To install a PWA, click the install icon in the site's address bar in Chrome.
This will add the app to an `~/Applications/Chrome Apps.localized/` folder.

In addition to inspecting the above folder, you can view and manage your
installed PWAs by visiting `chrome://apps` in Chrome.

To get Alfred to find and launch your PWAs, you need to add the above folder to
the "Search Scope" list in Alfred's "Features > Default Results" settings.

[google_pwa]: https://support.google.com/chrome/answer/9658361
