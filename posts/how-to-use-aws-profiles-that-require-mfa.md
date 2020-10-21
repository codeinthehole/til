---
title: "How to use AWS profiles that require MFA"
date: "2020-10-21T15:38:20+01:00"
tags: ["AWS"]
---

If you have an AWS organisation and several child AWS accounts that you can
assume-role into, you can work around MFA restrictions on the trust relationship
using a `mfa_serial` setting in `~/.aws/config`.

Example config:

```ini                                                                                        k
[profile parent]
# Account ID 111111111111
region = eu-west-2

[profile child-account1]
# Account ID 222222222222
role_arn = arn:aws:iam::222222222222:role/OrganizationAccountAccessRole
mfa_serial = arn:aws:iam::111111111111:mfa/david.winterbottom
region = eu-west-1
source_profile = parent 

[profile child-account2]
# Account ID 333333333333
role_arn = arn:aws:iam::333333333333:role/OrganizationAccountAccessRole
mfa_serial = arn:aws:iam::111111111111:mfa/david.winterbottom
region = eu-west-1
source_profile = parent 
```

Then you can make `aws` CLI calls into the child accounts and you'll be prompted
to enter your MFA code from your parent account IAM user.

```bash
$ aws --profile=child-account1 ec2 describe-instances
Enter MFA code for arn:aws:iam::111111111111:mfa/david.winterbottom:
{ 
    ...
}
```

You can find your `mfa_serial` string in the IAM dashboard. 

More info: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html#cli-configure-role-mfa

