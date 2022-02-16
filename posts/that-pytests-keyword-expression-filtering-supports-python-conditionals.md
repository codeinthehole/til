---
title: "That Pytest's \"keyword expression\" filtering supports Python conditionals"
date: "2021-07-16T15:17:08+01:00"
tags: ["pytest", "Testing", "Python"]
---

When using Pytest's `-k` filtering, you can use Python expressions to combine
separate search terms. For example:

```sh
pytest -k "TestSomeUnit and not test_foo"
```

will run all tests in a class matching `TestSomeUnit` but not those with method
name matching `test_foo`.

See the [Pytest docs on specifying which tests to run](https://docs.pytest.org/en/6.2.x/usage.html#specifying-tests-selecting-tests)
for more.
