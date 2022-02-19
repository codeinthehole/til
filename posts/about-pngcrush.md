---
title: "About `pngcrush`"
date: "2020-08-14"
tags: ["Command-line tools"]
---

It's an image optimizer for `.png` files. It's available via Homebrew for MacOS
and works like:

```bash
pngcrush -ow screenshot.png
```

where `-ow` means the original image file will be overwritten.

I've integrated it into the `til_screenshot.sh` helper script used by this repo.
