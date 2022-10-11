---
title: "Mypy skips empty functions"
date: "2022-10-11T09:56:57+01:00"
tags: ["mypy", "Python"]
---

Mypy doesn't check types of empty functions, such as those whose implementation
is `pass`, `...` or only a docstring.

For example, running `mypy` on this class:

```py
class C:
    def pass_only(self) -> int:
        pass

    def elipsis_only(self) -> int:
        ...

    def docstring_only(self) -> int:
        """
        Just a docstring, which implicitly returns `None`.
        """

    def docstring_and_none_return_type(self) -> int:
        """
        Now explicitly retiurn `None.
        """
        return None

    def incorrect_return_type(self) -> int:
        return "x"
```

only picks up errors on the latter two methods where there is an explicit return
value:

```txt
$ mypy --strict types_empty_methods.py
example.py:17: error: Incompatible return value type (got "None", expected "int")  [return-value]
example.py:20: error: Incompatible return value type (got "str", expected "int")  [return-value]
Found 2 errors in 1 file (checked 1 source file)
```

Such empty functions are normally used to indicate that a subclass should
provide a concrete implementation. However, real errors can occur if this is
omitted:

```pycon
>>> C().pass_only() + 1
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unsupported operand type(s) for +: 'NoneType' and 'int'
```

This is true as of Mypy v0.982 and below, but looks like [it will be fixed in a
upcoming release][mypy_issue].

Thanks to [Sam Searles-Bryant][ssb], who showed this to me.

[mypy_issue]: https://github.com/python/mypy/issues/2350
[ssb]: https://samueljsb.co.uk/
