---
title: "How to effectively scan files using an iPhone"
date: "2021-10-08T21:05:16+01:00"
tags: ["iOS"]
---

In iOS 13
[the Files app has a useful utility for scanning files](https://www.macrumors.com/how-to/scan-documents-ios-files-app/)
accessed via the ellipsis menu in the top-right of the screen.

The scanned document will be saved in your iCloud Drive folder. It will normally
be quite large, possibly too large for Gmail's 25Mb attachment limit. In that
case, use `ps2pdf` to reduce its file size:

```sh
ps2pdf scanned-file.pdf smaller-file.pdf
```

`ps2pdf` is provided by the
[`ghostscript` Homebrew package](https://formulae.brew.sh/formula/ghostscript)
installed with:

```sh
brew install ghostscript
```

This has worked well in my experience but there are alternatives on
[this Stack Overflow page](https://askubuntu.com/questions/113544/how-can-i-reduce-the-file-size-of-a-scanned-pdf-file).
