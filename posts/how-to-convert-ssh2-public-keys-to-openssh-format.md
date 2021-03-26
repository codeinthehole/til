---
title: "How to convert SSH2 public keys to OpenSSH format"
date: "2021-03-26T11:09:30+00:00"
tags: ["SSH"]
---

Turns out [`cloud-init`](https://cloudinit.readthedocs.io/en/latest/) requires
public keys to be in the single-line OpenSSH format but I was passing keys in
multi-line SSH2 format. `/var/log/cloud-init.log` was complaining that:

```txt
2021-03-25 15:31:55,032 - util.py[WARNING]: Failed loading yaml blob. Invalid format at line 22 column 1: "while scanning a simple key
  in "<unicode string>", line 22, column 1:
    AAAAB3NzaC1yc2EAAAABJQAAAQEAmZHH ...
    ^
could not find expected ':'
  in "<unicode string>", line 23, column 1:
    3EBOn0CEF2/aGO4Ja+bE05PdhmzNc3Tn ...
    ^"
```

To convert, use:

```bash
$ ssh-keygen -i -f ssh2.pub > openssh.pub
```

For the record, to convert the other way, use:
```bash
$ ssh-keygen -e -f openssh.pub > ssh2.pub
```


