---
title: "About text fragments"
date: "2020-08-10"
tags: ["browsers"]
---
Modern versions of Chrome and Edge support [Text Fragments](https://wicg.github.io/scroll-to-text-fragment/), 
which let you specify a text snippet in the URL fragment that the browser can
highlight (or bring to the user's attention in another way).

For example, opening https://wicg.github.io/scroll-to-text-fragment/#abstract:~:text=user%20agent%20can%20quickly%20emphasise
in Chrome will open the page with "user agent can quickly emphasise" highlighted:

{{< figure src="/images/text-fragment-example.png" title="" caption="" alt="text fragment example" >}}

Note the `:~:text=$query` in the URL.

There's a Google-authored [Chrome plugin](https://chrome.google.com/webstore/detail/link-to-text-fragment/pbcodcjpfjdpcineamnnmbkkmkdpajjg/related) that eases the process of building one of these URLs.

