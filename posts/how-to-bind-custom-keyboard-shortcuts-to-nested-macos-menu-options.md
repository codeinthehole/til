---
title: "How to bind custom keyboard shortcuts to nested MacOS menu options"
date: "2024-01-31T12:07:20+00:00"
tags: ["MacOS", "Bear"]
---

MacOS allows you to [override and bind new keyboard shortcuts for an
app][apple_docs].

This is done via the `System Settings > Keyboard > Keyboard Shortcuts...` UI, in
the `App Shortcuts` section of the left-hand nav, where you can define custom
mappings for any menu item.

{{< figure src="/images/customkeyboardshortcutsforapp.png" link="/images/customkeyboardshortcutsforapp.png" title="" caption="" alt="custom-keyboard-shortcuts-for-app" >}}

Today I discovered the syntax for adding mappings for _nested_ menu options:

```txt
${top_level_menu_name}->${nested_menu_name}
```

## Stop pasting rich text

I've used this in [Bear][bear_home] to add custom shortcuts for:

- Archiving a note
- Ensuring paste-from-plaintext is the default
- Opening a note in a new window

{{< figure src="/images/bear-custom-shortcuts.png" link="/images/bear-custom-shortcuts.png" title="" caption="" alt="bear custom shortcuts" >}}

[bear_home]: https://bear.app/
[apple_docs]: https://support.apple.com/en-gb/guide/mac-help/mchlp2271/mac
