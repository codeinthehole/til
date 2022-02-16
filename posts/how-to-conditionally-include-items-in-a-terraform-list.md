---
title: "How to conditionally include items in a Terraform list"
date: "2020-09-15T11:49:53+01:00"
tags: ["Terraform"]
---

It's not obvious how to build a Terraform list where an item is only included if
some condition is met. One solution is to use `flatten` along with a conditional
expression.

Something like this:

```hcl
resource "aws_security_group" "this" {
  ...
  ingress {
    ...
    security_groups = flatten([
      aws_security_group.server-type-a.id,
      var.include_server_type_b ? aws_security_group.server-type-b[*].id : []
    ])
  }
```

where the `server-type-b` security group is only included the `security_groups`
list if `var.include_server_type_b` is truthy.
