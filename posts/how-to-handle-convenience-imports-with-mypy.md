---
title: "How to handle convenience imports with Mypy"
date: "2022-11-23T17:24:46+00:00"
tags: ["mypy", "Python"]
---

Python convenience imports are where objects are imported into a package's
`__init__.py` module so client code has a simple, easy-to-remember location to
import objects from.

But, by default, Mypy will complain about such imports when run in strict mode.

## Example

For example, consider a `foo.__init__` module with contents:

```py
# foo/__init__.py
from ._queries import my_function
```

and a `main.py` module that imports `my_function` from the `foo` package:

```py
# main.py
from foo import my_function
...
```

Running `mypy --strict` on `main.py` yields an error:

```sh
$ mypy --strict main.py
main.py:1: error: Module "foo" does not explicitly export attribute "my_function"  [attr-defined]
Found 1 error in 1 file (checked 1 source file)
```

This error relates to the [`no_implicit_reexport`][docs_implicit_reexport]
setting which is enabled by Mypy's strict mode. This instructs Mypy to not
consider objects are exported unless:

- the item is imported using `from ... import ... as`;
- the item is included in the `__all__` module variable.

The above `foo.__init__` module does not meet either of these criteria. If we
want to conform to strict mode, the best approach is probably to add the objects
we want to reexport to a `__all__` variable:

```py
# foo/__init__.py
from ._queries import my_function

__all__ = ["my_function"]
```

## Patching module objects in tests

This is also a problem when using `mock.patch` to patch module objects in a
test.

For example, Mypy (in strict mode) will complain that this test attempts to
replace the `requests` object with a stub:

```py
# tests/test_vendors.py
from unittest import mock
from foo import vendors

@mock.patch.object(vendors, "requests")
def test_vendor_client(requests):
    # Stub some responses etc
    requests.post.return_value = ...
```

where `foo/vendors.py` imports the `requests` package:

```py
# foo/vendors.py
import requests
...
```

This generates a `attr-defined` error:

```sh
$ mypy tests/test_vendors.py
tests/test_vendors.py:4: error: "Module foo.vendors" does not explicitly export attribute "requests"  [attr-defined]
```

As before, importing `requests` like this indicates to Mypy that it isn't
available for re-export and so other modules, like our test module, cannot
reference it.

Since this is a common pattern in tests, it's better to ignore the error rather
than change the way packages are imported (e.g. to
`import requests as requests`).

This can be done in your Mypy config file:

```dosini
# setup.cfg
[mypy]
strict = true

[mypy-tests.*]
disable_error_code = attr-defined
```

This requires Mypy v0.991 or above to work.

[docs_implicit_reexport]:
  https://mypy.readthedocs.io/en/stable/command_line.html#cmdoption-mypy-no-implicit-reexport
