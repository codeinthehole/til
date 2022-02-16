---
title: "Sensitive Terraform Cloud variables are included in Sentinel mocks"
date: "2021-04-28T17:09:21+01:00"
tags: ["Terraform", "Sentinel", "Security"]
---

Hasicorp's [Sentinel](https://www.hashicorp.com/sentinel) framework allows you
to write tests using a mock Terraform plan file. A tarball of mock files can be
downloaded from the run detail page on Terraform Cloud:

{{< figure src="/images/terraform-cloud-download-sentinel-mocks.png" title="" caption="" alt="Terraform Cloud download Sentinel mocks" >}}

The tarball includes these files:

- `mock-tfconfig-v2.sentinel`
- `mock-tfconfig.sentinel`
- `mock-tfplan-v2.sentinel`
- `mock-tfplan.sentinel`
- `mock-tfrun.sentinel`
- `mock-tfstate-v2.sentinel`
- `mock-tfstate.sentinel`
- `sentinel.json`

What I only recently realised is that the `*-tfplan*` files include all your
workspace variables in plaintext, including those marked as sensitive.

To be fair [the Terraform docs do warn that mocks can contain sensitive state values](https://learn.hashicorp.com/tutorials/terraform/sentinel-testing?in=terraform/policy)
but I hadn't expected the wholespace variables to be included.

{{< figure src="/images/terraform-cloud-mocks-warning.png" title="" caption="" alt="Terraform Cloud mocks warning" >}}

Moral of the story: don't naively commit a Sentinel mock file, downloaded from
Terraform Cloud, into source control.
