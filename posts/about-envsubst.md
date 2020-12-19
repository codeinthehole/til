---
title: "About `envsubst`"
date: "2020-12-19T22:49:55+00:00"
tags: ["Command-line tools", "Kubernetes"]
---

Am learning Kubernetes and was looking for ways to dynamically create YAML
resource files.

I stumbled upon the [`envsubst` utility](https://www.gnu.org/software/gettext/manual/html_node/envsubst-Invocation.html)
which will substitute in the value of environment variables to STDIN.

Eg:
```bash
> export foo=bar
> echo '$foo'
$foo
> echo '$foo' | envsubst
bar
```

So you could have a Kubernetes `deployment.yml` file where the image tag is set
by a environment variable instead of being hard-coded:

```bash
> export DOCKER_IMAGE_TAG=...
> cat deployment.yml | envsubst | kubectl apply -f -
```

I'm sure there are better ways of setting up Kubernetes deployment pipelines but
this is a neat trick to know.




