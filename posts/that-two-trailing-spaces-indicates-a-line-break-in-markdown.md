---
title: "That two trailing spaces indicates a line break in Markdown"
date: "2023-07-01T18:57:50+01:00"
tags: ["Markdown", "Github"]
---

Not sure how I've never come across this before, but Markdown supports hard line
breaks by ending a line with two spaces. Don't strip trailing whitespace in your
Markdown editor pre-save hooks.

From the original [Markdown spec][daringfireball]:

> A paragraph is simply one or more consecutive lines of text, separated by one
> or more blank lines. (A blank line is any line that looks like a blank
> line — a line containing nothing but spaces or tabs is considered blank.)
> Normal paragraphs should not be indented with spaces or tabs.
>
> The implication of the “one or more consecutive lines of text” rule is that
> Markdown supports “hard-wrapped” text paragraphs. This differs significantly
> from most other text-to-HTML formatters (including Movable Type’s “Convert
> Line Breaks” option) which translate every line break character in a paragraph
> into a `<br />` tag.
>
> When you do want to insert a `<br />` break tag using Markdown, you end a line
> with two or more spaces, then type return.

I've never found a need for this, but you might if you were writing poetry or
other text that doesn't conform to the usual paragraph structure.

## Quoting poetry in Github comments

Oddly, consecutive lines of block quoted text aren't joined together in Github's
flavour of Markdown (GFM) so people quoting poets don't need to add trailing
spaces there.

That is:

```txt
> On the Ning Nang Nong
> Where the Cows go Bong!
```

converts the new line character into a `<br />`:

```html
<p>
  On the Ning Nang Nong<br />
  Where the Cows go Bong!
</p>
```

This seems at odds with [the GFM spec][gfm_spec] which indicates it should
render as:

```html
<p>On the Ning Nang Nong Where the Cows go Bong!</p>
```

Hugo's Goldmark Markdown library does join the quoted lines together.

[daringfireball]: https://daringfireball.net/projects/markdown/syntax#p
[gfm_spec]: https://github.github.com/gfm/#example-206
