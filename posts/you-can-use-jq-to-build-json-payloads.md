---
title: "You can use JQ to build JSON payloads"
date: "2022-11-18T19:24:31+00:00"
tags: ["JQ"]
---

It's possible to use [JQ][jq] to _build_ JSON payloads as well as filter them.

This is useful when constructing dynamic JSON payloads at the CLI as JQ will
escape input variables correctly.

Simple example:

```sh
$ jq -n --arg name "Alan" '{name: $name}'
{
  "name": "Alan"
}
```

The `-n` (`--null-input`) option tells JQ not to read any input.

Values passed with `--arg` will always serialise as strings:

```sh
$ jq -n --arg name "Alan" --arg age 20 '{name: $name, age: $age}'
{
  "name": "Alan",
  "age": "20"
}
```

To serialize other types, use `--argjson`:

```sh
$ jq -n --arg name "Alan" --argjson age 20 '{name: $name, age: $age}'
{
  "name": "Alan",
  "age": 20
}
```

Using JQ in this way is useful for making HTTP requests as the dynamic JSON
payload can be piped into `http`:

```sh
$ jq -n --arg name "Alan" --argjson age 20 '{name: $name, age: $age}' \
    | http https://example.com/api/users/register/
```

See my [post on using OpenAI to convert commit messages into
poems][openai_poetry] for a more complete example.

[jq]: https://stedolan.github.io/jq/
[openai_poetry]: https://codeinthehole.com/tidbits/openai-git-poetry/
