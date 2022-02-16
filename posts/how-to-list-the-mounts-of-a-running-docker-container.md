---
title: "How to list the mounts of a running Docker container"
date: "2021-12-07T10:42:03+00:00"
tags: ["Docker", "Discourse"]
---

Use `docker inspect` like so:

```sh
docker inspect -f "{{ .Mounts }}" $CONTAINER_ID
```

I used this to determine where a [Discourse Docker](https://github.com/discourse/discourse_docker) container was persisting its logs:

```sh
$ docker inspect -f "{{ .Mounts }}" $(docker ps -q --filter="name=app")
[{bind  /var/discourse/shared/standalone /shared   true rprivate} {bind  /var/discourse/shared/standalone/log/var-log /var/log   true rprivate}]
```

Here you can see logs are mounted from `/var/discourse/shared/standalone/log/var-log`.
