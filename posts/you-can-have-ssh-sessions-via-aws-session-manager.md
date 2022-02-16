---
title: "You can have SSH sessions via AWS Session Manager"
date: "2021-08-09T12:26:02+01:00"
tags: ["AWS", "SSH"]
---

This can be achieved by adding a block like this to your `~/.ssh/config`:

```ssh
host i-* mi-*
    ProxyCommand sh -c "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
```

This allows an SSH session to be started with:

```sh
ssh $INSTANCE_ID
```

If you work with more than one AWS account, you can use a pseudo host string to
indicate which AWS profile to use:

```ssh
Host i-*.*
    ProxyCommand sh -c "aws --profile=$(echo %h | cut -d'.' -f2) ssm start-session --target $(echo %h | cut -d'.' -f1) --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
```

where we pass hosts in the form `$INSTANCE_ID.$PROFILE_NAME`. For example:

```sh
ssh i-0c47f1891eb987860.staging
```

Note that commands aren't logged for SSH sessions.

For more see the [AWS SSM docs].

[AWS SSM docs]: https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-enable-ssh-connections.html
