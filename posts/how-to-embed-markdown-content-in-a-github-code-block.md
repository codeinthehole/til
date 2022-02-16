---
title: "How to embed markdown content in a Github code block"
date: "2020-10-27T16:39:43+00:00"
tags: ["Github", "Markdown"]
---

Normally,
[fenced code blocks](https://docs.github.com/en/free-pro-team@latest/github/writing-on-github/creating-and-highlighting-code-blocks)
are delimited with triple backticks ` ``` `.

If your code block is a markdown snippet including triple backticks, then the
solution is to delimit with a block of 4 (or more) backticks.

`````markdown
This is how you create code blocks in markdown:

````
Here is the code:
```
def hello():
   return "hello"
```
````
`````
