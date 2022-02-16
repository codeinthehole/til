---
title: "How to configure `ctags` to parse Terraform files"
date: "2020-11-26T16:09:12+00:00"
tags: ["Ctags", "Vim"]
---

If you're using [Universal Ctags](https://github.com/universal-ctags/ctags)
(which you should be), you just need to add a `~/.ctags.d/terraform.ctags` with
contents:

```txt
--langdef=terraform
--langmap=terraform:.tf.tfvars
--regex-terraform=/^[[:space:]]*resource[[:space:]]*"([^"]*)"[[:space:]]*"([^"]*)"/\2/r,Resource/
--regex-terraform=/^[[:space:]]*data[[:space:]]*"([^"]*)"[[:space:]]*"([^"]*)"/\2/d,Data/
--regex-terraform=/^[[:space:]]*variable[[:space:]]*"([^"]*)"/\1/v,Variable/
--regex-terraform=/^[[:space:]]*provider[[:space:]]*"([^"]*)"/\1/p,Provider/
--regex-terraform=/^[[:space:]]*module[[:space:]]*"([^"]*)"/\1/m,Module/
--regex-terraform=/^[[:space:]]*output[[:space:]]*"([^"]*)"/\1/o,Output/
--regex-terraform=/^([a-z0-9_]+)[[:space:]]*=/\1/f,TFVar/
```

Then, for example, a Terraform resource like:

```terraform
resource "aws_cloudwatch_log_group" "my-log-group" {
  name = "my-log-group"
  ...
}
```

will have `my-log-group` stored as an identifier so you can jump to its
definition from other references.

Inspiration taken from
[ctag support for Terraform](https://z0mbix.io/2016/09/04/ctag-support-for-terraform/)
although the snippet above is a slightly amended version from the
[vim-terraform-completion](https://github.com/juliosueiras/vim-terraform-completion/blob/master/ctags/terraform.ctags)
repo.
