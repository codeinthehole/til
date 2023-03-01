---
title: "How to create a word cloud from text piped via STDIN"
date: "2023-03-01T21:36:32+00:00"
tags: ["Command-line tools", "Python"]
---

There's a [`word_cloud` generator package][pypi_wordcloud] available from PyPI
that can take its source text from STDIN:

```sh
cat the-bible.txt | wordcloud_cli --imagefile bible.png
```

For fun, you can create a word cloud of all your commit subjects from a repo:

```sh
git log --author="$AUTHOR" --no-merges --format="%s" | \
    wordcloud_cli --background=white --imagefile=commits.png
```

which, for this repo, yields:

{{< figure src="/images/wordcloud-commits.png" title="" caption="" alt="A word cloud of commits." >}}

[pypi_wordcloud]: https://github.com/amueller/word_cloud
