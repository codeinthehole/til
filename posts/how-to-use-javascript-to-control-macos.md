---
title: "How to use JavaScript to control MacOS"
date: "2023-10-12T21:36:24+01:00"
tags: ["Javascript", "MacOS"]
---

The `osascript` command can run JavaScript as well as AppleScript for
interacting with MacOS.

For example, a `script.js` JavaScript file can be run with:

```sh
osascript -l JavaScript script.js
```

or use a hashbang of:

```sh
#!/usr/bin/env osascript -l JavaScript
```

Running Javascript scripts with `osascript` will invoke a `run` function (if one
exists).

The JavaScript environment will have additional global objects for interacting
with MacOS. You can identify them through comparison with a Node (v20.5.1)
environment:

```sh
> cmd="console.log(Object.getOwnPropertyNames(this).join('\n'))"
> osascript -l JavaScript -e "$cmd" 2>&1 | sort > osascript.txt
> node -e "$cmd" | sort > node.txt
> comm -23 osascript.txt node.txt
$
Application
Automation
Library
ObjC
ObjectSpecifier
Path
Progress
Ref
__private__
delay
```

It's not particularly easy to find documentation for these APIs but here's a few
examples.

## Examples

The `Application` object allows you to open and manipulate MacOS applications -
e.g.

```js
#!/usr/bin/env osascript -l JavaScript

function run() {
  let chrome = Application("Google Chrome");
  if (!chrome.running()) {
    chrome.activate();
  }
}
```

as well as create notifications:

```js
#!/usr/bin/env osascript -l JavaScript

app = Application.currentApplication();
app.includeStandardAdditions = true;
app.displayNotification("Hello, Notification", {
  withTitle: "Notification Title",
  subtitle: "Subtitle",
  soundName: "default",
});
```

The `ObjC` object allows you to interact with Objective-C objects to do things
like access environment variables:

```js
#!/usr/bin/env osascript -l JavaScript

function run(args) {
  ObjC.import("stdlib");
  let browser = $.getenv("BROWSER");
}
```
