---
title: "Docker for Mac stores all containers and images in a single disk image"
date: "2022-03-09T15:59:20+00:00"
tags: ["Docker"]
---

All images and containers are stored in:

```txt
~/Library/Containers/com.docker.docker/Data/vms/0/data/Docker.raw
```

as opposed to Linux which uses the `/var/lib/docker` directory.

The size of this image can be configured in the Docker for Mac system
preferences:

{{< figure src="/images/docker-for-mac-resources.png" title="" caption="" alt="Docker for Mac resources" >}}

If you find `docker build` is erroring with a "No space left on device" error,
this is a likely cause. You can free up space in this disk image by running:

```sh
docker system prune
```

There's more info in the [Docker docs on disk utilization][disk_docs].

[disk_docs]: https://docs.docker.com/desktop/mac/space/
