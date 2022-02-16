---
title: "How to read from one buffer to another in Vim"
date: "2020-09-23T16:00:09+01:00"
tags: ["Vim"]
---
Refer to the buffer's number using a hash. For example, run:

```vim
:read #3
```

to insert the contents of _the file_ linked to buffer 3. Note that a buffer's
content isn't necessarily the same as the linked file.

From: <https://stackoverflow.com/questions/37859530/vim-how-to-read-from-one-buffer-into-another>
