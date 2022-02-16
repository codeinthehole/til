---
title: "SSH config supports multiple host patterns in one block"
date: "2020-09-23T10:16:13+01:00"
tags: ["OpenSSH"]
---

From `man ssh_config`:

> Host Restricts the following declarations (up to the next Host or Match
> keyword) to be only for those hosts that match one of the patterns given after
> the keyword. If more than one pattern is provided, they should be separated by
> whitespace.

and so you can do this:

```ssh
Host 10.0.20.* 10.0.28.* 10.0.29.* 10.0.30.*
    User ubuntu
    IdentityFile ~/.ssh/xxx/id_rsa
    ProxyJump some-bastion-host
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
```

where multiple host patterns are used for one block.
