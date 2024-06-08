---
title: "How to use `jq` to only parse valid JSON lines"
date: "2023-08-10T15:44:41+01:00"
tags: ["JQ"]
---

Suppose you have a stream of text comprising JSON and non-JSON lines — e.g:

```sh
$ cat example.txt
This is plain text
{"message": "This is JSON"}
```

and you want to pretty-print the JSON lines to make the stream more readable.

Piping this into `jq` fails because the first line is not valid JSON:

```sh
$ cat example.txt | jq
parse error: Invalid numeric literal at line 1, column 5
```

But you use `jq`'s `fromjson` filter in a `try/catch` block to format the JSON
lines and ignore the others:

```sh
$ cat example.txt | jq -R '. as $line | try (fromjson) catch $line'
"This is plain text"
{
  "message": "This is JSON"
}
```

This works well when
[running uWSGI with JSON logging enabled](/posts/how-to-get-uwsgis-logroute-to-support-regular-expressions/),
where the initial log lines are not JSON formatted.
