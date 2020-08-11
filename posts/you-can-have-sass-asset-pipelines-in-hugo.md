---
title: "You can have SASS asset pipelines in Hugo"
date: "2020-08-11"
tags: ["hugo", "sass"]
---

Which lets you build a CSS stylesheet via something like:

```html
{{ $style := resources.Get "css/main.scss" | resources.ToCSS }}
<link rel="stylesheet" href="{{ $style.Permalink }}">
```

This is rather nice as you get the usual live reloading functionality when using
`hugo server`. In previous Hugo projects, I had a separate process for
rebuilding CSS, which can now be factored away. 

This feature is part of Hugo's [asset
pipeline](https://gohugo.io/hugo-pipes/introduction/) functionality and has been
available since v0.43.

See https://gohugo.io/hugo-pipes/scss-sass/


