---
title: "About Bash's `compgen` built-in"
date: "2024-05-10T15:47:17+01:00"
tags: ["Bash", "Docker"]
---

Bash includes a built-in `compgen` command that can list all the commands
available in the current shell:

```sh
compgen -c  # List all commands
```

It can do other useful things too:

```sh
compgen -a  # List all aliases
compgen -b  # List all Bash built-ins
compgen -k  # List all Bash keywords
compgen -A function   # List all Bash functions
```

### Inspecting Docker images

I stumbled on this while trying to see which Python versions were included in a
`cimg/python` Docker image. That can be done with:

```sh
$ docker run -t cimg/python:3.11 /bin/bash -c "compgen -c" \
    | grep python3 | sort | uniq
python3
python3-config
python3.10
python3.11
python3.11-config
python3.11-gdb.py
```

We need to use `/bin/bash -c` as the default shell for the `cimg/python` image
is `/bin/sh`, which doesn't support the `compgen` command.

### More information

Help for `compgen` can be found in the `man bash` page. See also
[this useful overview](https://www.cyberciti.biz/open-source/command-line-hacks/compgen-linux-command/).
