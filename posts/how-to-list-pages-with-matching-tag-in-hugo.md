---
title: "How to list pages with matching tag in Hugo"
date: "2020-08-17T14:32:50+01:00"
tags: ["Hugo"]
---

In a detail template, you can grab a post's tags with `{{ .GetTerms "tags"
}}`. You can then loop over this and fetch a list of pages with each tag,
excluding the current post:

```html
{{ range $tag_pages }}
    {{ $related_tag_pages := where .Pages "Title" "!=" $.Title }}
    {{ if $related_tag_pages }}
        <p>Other things learnt about <a href="{{ .Permalink }}">{{ .Title | markdownify }}</a>:</p>
        <ul>
        {{ range $related_tag_pages }}
            <li><a href="{{ .RelPermalink }}">{{ .Title | markdownify }}</a></li>
        {{ end }}
        </ul>
    {{ end }}
{{ end }}
```

Tested in Hugo v0.72.0.

