---
title: "AWS target groups fail open when all instances are unhealthy"
date: "2022-09-24T13:44:07+01:00"
tags: ["AWS"]
---

In normal conditions, an AWS load balancer will only route requests to healthy
instances in its linked target group. But a "fail open" policy is applied if all
targets in the target group are unhealthy. From the [AWS ELB docs][aws_docs]:

> If a target group contains only unhealthy registered targets, the load
> balancer routes requests to all those targets, regardless of their health
> status. This means that if all targets fail health checks at the same time in
> all enabled Availability Zones, the load balancer fails open. The effect of
> the fail-open is to allow traffic to all targets in all enabled Availability
> Zones, regardless of their health status, based on the load balancing
> algorithm.

This came up at Kraken Tech where an unusual misconfiguration caused all
instances in a target group to become unhealthy, and I was initially puzzled as
to why new instances — which had never passed their health checks — were serving
production traffic.

[aws_docs]:https://docs.aws.amazon.com/elasticloadbalancing/latest/application/target-group-health-checks.html
