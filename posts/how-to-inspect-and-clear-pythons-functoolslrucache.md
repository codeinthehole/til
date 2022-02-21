---
title: "How to inspect and clear Python's `functools.lru_cache`"
date: "2022-02-21T21:01:02+00:00"
tags: ["Python"]
---

Python's [`functools.lru_cache`][python_docs] binds two additional functions to
decorated functions:

- `cache_info` which returns statistics about cache hits and misses, and;
- `cache_clear` which clears the cache.

## Flakey tests

I've found `functools.lru_cache` use to be a common factor of flakey tests,
where behaviour changes depending on the order in which tests run (which affects
which value gets cached). The symptoms are often that a test passes when run on
its own but intermittently fails when run as part of a larger group.

Avoid this by clearing related LRU caches as part of each test's tear-down
process:

```py
import pytest
from somemodule import cached_function

@pytest.fixture(autouse=True)
def clear_lru_cache():
    # Execute the test...
    yield

    # ...then clear the LRU cache.
    cached_function.cache_clear()
```

[python_docs]:
  https://docs.python.org/3/library/functools.html#functools.lru_cache
