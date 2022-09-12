---
title: "It's better to explicitly chain Python exceptions"
date: "2022-09-12T18:16:01+01:00"
tags: ["Python"]
---

When converting one type of exception to another in an `except` block, it's best
to [explicitly chain them][exception_chaining] using the `from` keyword.

That is, prefer this:

```py
def eat_lunch():
    try:
        make_cheese_on_toast()
    except NoCheese as e:
        raise UnableToEat("Need to go shopping") from e
```

to:

```py
def eat_lunch():
    try:
        make_cheese_on_toast()
    except NoCheese:
        raise UnableToEat("Need to go shopping")
```

The former will [set the `__cause__` attribute][exception_context] on the newly
raised `UnableToEat` exception, indicating that the `NoCheese` exception was a
direct cause.

This leads to a better stack trace message where the two stack traces are
combined with a sentence indicating one was a "direct cause" of the other:

```txt
Traceback (most recent call last):
  File "lunch.py", line 10, in eat_lunch
    make_cheese_on_toast()
  File "lunch.py", line 5, in make_cheese_on_toast
    raise NoCheese
__main__.NoCheese

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "lunch.py", line 15, in <module>
    eat_lunch()
  File "lunch.py", line 12, in eat_lunch
    raise UnableToEat("Need to go shopping") from e
__main__.UnableToEat: Need to go shopping
```

Without the explicit chaining, the joining message would be:

```
During handling of the above exception, another exception occurred
```

[exception_chaining]:
  https://docs.python.org/3/tutorial/errors.html#exception-chaining
[exception_context]:
  https://docs.python.org/3/library/exceptions.html#exception-context
