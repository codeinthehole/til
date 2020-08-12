+++
title = "Renaming a Terraform module is dangerous"
date = "2020-07-23"
tags = ["Terraform"]
+++

As the state file uses the module name in identifiers and so a module rename causes
Terraform to think all existing resources need to be destroyed and recreated.

You can avoid such needless destruction by editing the state file manually to
correct the identifiers.

It might be possible to use `terraform mv` although I didn't use that approach
today.
