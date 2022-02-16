---
title: "AWS ASGs have an 'instance refresh' feature"
date: "2020-09-28T16:02:44+01:00"
tags: ["AWS", "Terraform"]
---

Which lets you replace all the instances in an auto-scaling group, possibly with
a new AMI. See
[the announcement](https://aws.amazon.com/blogs/compute/introducing-instance-refresh-for-ec2-auto-scaling/)
from the AWS Compute Blog.

If you use an immutable infrastructure approach and deploy using AMIs, this
provides an alternative deployment mechanism. In contrast to using Terraform's
`create_before_destroy` mechanism, which creates a new auto-scaling group for
each deploy, this method would allow a single long-lived ASG to be used.

Looks interesting.
