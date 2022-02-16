---
title: "How to use `aws-mfa-v2` to avoid entering so many MFA tokens"
date: "2021-11-08T17:48:54+00:00"
tags: ["AWS", "Python"]
---

Prior to being told about [`aws-mfa-v2`](https://github.com/rkeiii/aws-mfa-v2)
my `~/.aws/config` file looked like this:

```dosini
[profile parent-account]
region = eu-west-1

[profile child-account]
mfa_serial = arn:aws:iam::$PARENT_AWS_ACCOUNT_ID:mfa/$USERNAME
role_arn = arn:aws:iam::$CHILD_AWS_ACCOUNT_ID:role/$ROLE_NAME
region = eu-west-1
source_profile = parent-account
```

which worked fine but meant `awscli` calls using the `child-account` profile
prompted for an MFA token. Over the course of a day I would look up a token many
times.

But following a tip from [James Tunnicliffe](https://github.com/dooferlad) I
greatly reduced how often I need to do this by using the `aws-mfa-v2` utility.
This uses your long-lived AWS account to create temporary profiles with
credentials fetched from AWS STS.

In practice, this requires you to run:

```sh
aws-mfa --mfa-profile parent-account --token $TOKEN
```

once a day to create/update a temporary AWS profile (called, in this example,
`parent-account-mfa`).

Plus I needed to rearrange `~/.aws/config` to have this structure:

```dosini
[profile parent-account]
region = eu-west-1
mfa_serial = arn:aws:iam::$PARENT_AWS_ACCOUNT_ID:mfa/$USERNAME

[profile child-account]
role_arn = arn:aws:iam::$CHILD_AWS_ACCOUNT_ID:role/$ROLE_NAME
region = eu-west-1
source_profile = parent-account-mfa
```

Note the updated `source_profile` value that refers to a profile only defined in
`~/.aws/credentials`.
