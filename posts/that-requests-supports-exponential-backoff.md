---
title: "That `requests` supports automatic retries with exponential back-off"
date: "2024-11-27T15:51:31+00:00"
tags: ["Python"]
summary: "`requests` supports automatic retries with backoff"
---

It's possible to define a retry strategy for a `requests.Session` instance by
mounting a customised adapter:

<!--more-->

```python
import requests
from requests import adapters
from urllib3.util import Retry

# Create a transport adapter with a custom retry strategy.
retries = Retry(
    # Max retries.
    total=5,
    # Exponential backoff factor.
    backoff_factor=1,
    # Which HTTP status codes to retry on.
    status_forcelist=[500, 502, 503, 504]
)
adapter = adapters.HTTPAdapter(max_retries=retries)

# Ensure adapter is used for both HTTP and HTTPS requests.
session = requests.Session()
session.mount('https://', adapter)
session.mount('http://', adapter)
```

Now all requests will employ an automatic retry-with-backoff strategy. If the
max retries are exceeded, a `requests.exceptions.RetryError` is raised.
Something like:

```text
requests.exceptions.RetryError: HTTPConnectionPool(...): Max retries exceeded
with url: ... (Caused by ResponseError('too many 429 error responses'))
```

Related docs:

- [`urllib3.util.Retry`][retry]
- [`requests.adapters.HTTPAdapter`][adapter]
- [`requests.Session`][session]

[retry]:
  https://urllib3.readthedocs.io/en/latest/reference/urllib3.util.html#urllib3.util.Retry
[adapter]:
  https://requests.readthedocs.io/en/latest/api/#requests.adapters.HTTPAdapter
[session]: https://requests.readthedocs.io/en/latest/api/#requests.Session
