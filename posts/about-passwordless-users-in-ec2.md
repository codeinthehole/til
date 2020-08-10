+++
title = "Where authentication for the `ubuntu` user on a EC2 instance is defined"
date = "2020-07-22"
tags = ["aws", "ubuntu"]
+++

The file that controls where the default `ubuntu` user on an Ubuntu EC2 instance
is `/etc/sudoers.d/90-cloud-init-users` which has contents:

```txt
# User rules for ubuntu
ubuntu ALL=(ALL) NOPASSWD:ALL
```

```py
def f(a: int) -> int:
    return None
```

As you can see, the default `ubuntu` user has password-less, `sudo` access.

Source https://serverfault.com/questions/615034/disable-nopasswd-sudo-access-for-ubuntu-user-on-an-ec2-instance
