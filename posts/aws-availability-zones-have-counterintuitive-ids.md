---
title: "AWS Availability Zones have counter-intuitive IDs"
date: "2020-08-25T22:18:32+01:00"
tags: ["AWS"]
---
Today, the [AWS Service Health Dashboard](https://status.aws.amazon.com/#EU_block) referred to an Availability Zone in a way I wasn't familiar
with:

> 3:52 AM PDT We are experiencing instance connectivity issues in a single Availability Zone (euw2-az2) in the EU-WEST-2 Region.

See:

{{< figure src="/images/aws-status-message.png" title="" caption="" alt="AWS status message" >}}

Here "euw2-az2" is the "Zone ID" of the Availability Zone, and the mapping from
Zone ID to the more familiar Zone Name is non-obvious. See, for example:

```bash
$ aws ec2 describe-availability-zones --region eu-west-2 | jq -r '.AvailabilityZones[] | [ .ZoneName, .ZoneId ] | join(" = ")'
eu-west-2a = euw2-az2
eu-west-2b = euw2-az3
eu-west-2c = euw2-az1
```

As you can see `a,b,c` doesn't map onto `1,2,3`.



