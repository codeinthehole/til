---
title: "About `column`"
date: "2020-11-12T14:43:50+00:00"
tags: ["Command-line tools"]
---

Which formats input into columns. This is useful for formatting data into a
table structure.

Example usage: printing a table of running EC2 instances:

```bash
$ aws ec2 describe-instances --filters="Name=instance-state-name,Values=running" \
    | jq -r '.Reservations[].Instances[] | [ .InstanceId, .PrivateIpAddress ] | join("|")' \
    | column -t -s "|"
i-0fe1eb8debbff316f  10.0.0.54
i-0ed0af108b30084a2  10.0.20.202
i-0935f54b5a3002760  10.0.1.83
i-063621cd0118bc69d  10.0.248.118
i-0f11a4f1cea7d60da  10.0.238.126
i-01bb8c6bf2a4109e5  10.0.234.252
i-03e990e42886c2da3  10.0.237.103
i-011e55d5fab3aad13  10.0.238.213
i-02651b70f191f7068  10.0.29.221
i-0b07423fbf8b79554  10.0.29.85
i-04e5c99694eb27c92  10.0.29.7
```

Here we use `jq` to build a pipe-separated stream of instance data which is
tabulated by `column`.

You can add a header row using either `awk`:

```bash
$ aws ec2 describe-instances --filters="Name=instance-state-name,Values=running" \
    | jq -r '.Reservations[].Instances[] | [ .InstanceId, .PrivateIpAddress ] | join("|")' \
    | awk 'BEGIN { print "Instance ID|Private IP address" } { print }' |
    | column -t -s "|"
Instance ID          Private IP address
i-0fe1eb8debbff316f  10.0.0.54
i-0ed0af108b30084a2  10.0.20.202
...
```
or `sed`:

```bash
$ aws ec2 describe-instances --filters="Name=instance-state-name,Values=running" \
    | jq -r '.Reservations[].Instances[] | [ .InstanceId, .PrivateIpAddress ] | join("|")' \
    | sed -e $'1i\\\nInstance ID|Private IP address'
    | column -t -s "|"
Instance ID          Private IP address
i-0fe1eb8debbff316f  10.0.0.54
i-0ed0af108b30084a2  10.0.20.202
...
```

The `awk` version is easier to understand.

See https://man.openbsd.org/column.1 for more.



