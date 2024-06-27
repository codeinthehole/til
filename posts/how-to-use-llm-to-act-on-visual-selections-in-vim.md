---
title: "How to use `llm` to act on visual selections in Vim"
date: "2024-06-27T16:25:27+01:00"
tags: ["LLM", "Vim"]
summary: ""
---

You can use Simon Willison's excellent [`llm` tool][llm] to query or edit Vim
buffers by piping the contents of a visual selection to the `llm`.

<!--more-->

Select some text in visual mode then hit `:` to enter command mode with range
selected (`:'<,'>`). Then you can do things like:

- Ask a question about the selected text and see the output in Vim's status bar

  ```vim
  :'<,'>:w !llm "Explain what this function does"
  ```

  The `:w` ensures output is displayed in the status bar rather than replacing
  the selected text.

- Edit the selected text in place. E.g.

  ```vim
  :'<,'>!llm "Add a docstring to this function"
  :'<,'>!llm "Add type hints to this function"
  :'<,'>!llm "Improve the grammar of this paragraph"
  ```

  It's early days but I haven't found this to work _particularly_ well yet. I
  suspect a better model is required than GPT3.5.

- Use the `llm` output to create other files:

  ```vim
  :'<,'>!llm "Write unit tests for this function using Pytest" > tests/test_foo.py
  ```

Seems quite promising.

While [Github CoPilot][copilot] provides useful(ish) suggestions when composing,
an LLM tool that can effectively _edit_ the current buffer (or generate new
files) would be very powerful.

--

Hat-tip to my colleague [Samuel Liedtke][sam] for [a really useful
blog][sam_post] post that sent me off in this direction.

[llm]: https://llm.datasette.io/en/stable/
[sam]: https://www.samuelliedtke.com/about/
[sam_post]: https://www.samuelliedtke.com/blog/using-llms-on-the-command-line
[copilot]: https://github.com/github/copilot.vim
