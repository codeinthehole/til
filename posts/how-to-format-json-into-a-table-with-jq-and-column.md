---
title: "How to format JSON into a table with `jq` and `column`"
date: "2023-01-05T11:19:09+00:00"
tags: ["JQ", "Command-line tools"]
---

You can create tabular data from JSON using `jq` to generate tab-separated
output and `column` to format.

```sh
$ echo sample.json | jq -r '.[] | [.name, .age] | @tsv' | column -t -s $'\t'
```

Here's a more involved example using Github's [`gh` tool][gh] to fetch a list of
open pull requests:

```sh
$ gh pr list --json number,title,author \
    | jq -r '.[] | [ .author.login, "#" + (.number|tostring) + " " + .title] | @tsv' \
    | column -t -s$'\t'
codeinthehole   #450 Add convention on accessing environment variables
LomaxOnTheRun   #449 Move info from Github wiki
codeinthehole   #443 Format all files with `proseWrap=always`
datur           #428 Refactor GraphQL versioning and deprecation Conventions
Dotrar          #427 Add next-page template information
cloverlime      #425 Add advice for creating indexes on big tables
zero4994        #419 Add notes to pycharm guide
```

I spotted the `column` tip in [this Stack Overflow answer][so_answer].

## Shell alias

The `column` command is a little awkward due to the way the tab character needs
to be escaped. You can create a shell alias to aid future use:

```sh
alias tabcolumns='column -t -s$'\''\t'\'''
```

Here the escaping is even worse but at least you don't have to type it in every
time.

---

<small>Update: just discovered [this isn't the first time I've learnt
this...][previous_post]</small>

[so_answer]: https://stackoverflow.com/a/39144364
[gh]: https://cli.github.com/
[previous_post]: /posts/about-column/
