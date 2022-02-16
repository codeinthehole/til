---
title: "You can take screenshots with Chrome DevTools"
date: "2021-01-25T17:33:45+00:00"
tags: ["Chrome"]
---

Chrome DevTools can take screenshots via its [Command Menu](https://developers.google.com/web/tools/chrome-devtools/command-menu)
(which can be opened with `cmd + shift + p`).

{{< figure src="/images/chrome-command-menu.png" title="" caption="" alt="Chrome command menu" >}}

MacOS users already have `cmd + shift + 4` for grabbing screenshots areas of the
screen but there's two new things that Chrome Commands can do:

1. `Capture full size screenshot` — Take a screenshot of the full web page, not
   just the visible part.

2. `Capture node screenshot` — Take a screenshot of the currently selected
   element in the DOM (i.e. selected in the "Elements" tab).
