---
title: "How to enable Docker BuildKit in MacOS Docker Desktop"
date: "2020-12-29T15:55:34+00:00"
tags: ["Docker"]
---

Since Docker 18.09, you can the BuildKit feature to take advantages of improved
performance and extra features when building images — see [Build images with
Buildkit](https://docs.docker.com/develop/develop-images/build_enhancements/) from the Docker docs.

MacOS users using [Docker
Desktop](https://www.docker.com/products/docker-desktop), can enable this be
update the Docker daemon JSON config file to:

```json
{
    "experimental": false,
    "debug": true,
    "features": {
        "buildkit": true
    }
}
```

This is done via the `Preferences > Docker Engine` menu option in the GUI.

(This is accurate as of Docker Desktop v3.0.3)
