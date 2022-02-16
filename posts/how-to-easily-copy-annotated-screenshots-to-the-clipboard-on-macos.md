---
title: "How to easily copy annotated screenshots to the clipboard on macOS"
date: "2021-09-13T14:26:37+01:00"
tags: ["macOS"]
---

I frequently want to take screenshots, annotate them, then paste the marked up
image into an application like Slack or Github; I don't want to save a file to
the `~/Desktop`.

### Before today

Prior to today, my workflow for this was:

1. Use `⇧ + ⌘ + 4` to
   [take a screenshot of a portion of the screen](https://support.apple.com/en-gb/HT201361).
2. Click the thumbnail in the bottom right to open the Markup editor.
3. Mark up the screenshot.
4. Use `⇧ + ⌃ + ⌘ + 4` to copy a screenshot of the Markup editor to the
   clipboard (which is a bit awkward).
5. Paste the image.
6. Hit the trash button in the Markup editor to discard the marked up image.

Taking a screenshot of a screenshot editor never felt right.

### After today

Today
[I've learnt](https://apple.stackexchange.com/questions/367962/how-to-copy-an-image-from-screenshots-markup)
that you can copy the marked up image to the clipboard using the conventional
`⌘ + c` binding in the Markup editor. This simplifies the above workflow to:

1. Use `⇧ + ⌘ + 4` to take a screenshot of a portion of the screen.
2. Click the thumbnail in the bottom right to open the Markup editor.
3. Mark up the screenshot.
4. Use `⌘ + c` to copy the marked up image to the clipboard.
5. Paste the image.
6. Hit the trash button in the Markup editor to discard the marked up image.

The same number of steps but a much simpler journey.
