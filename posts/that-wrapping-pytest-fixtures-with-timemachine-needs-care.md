---
title: "That wrapping Pytest fixtures with `time_machine` needs care"
date: "2024-08-01T19:47:05+01:00"
tags: ["Testing", "Python", "Pytest"]
summary: ""
---

There's several gotchas to be aware of when using [`time_machine`][time_machine]
with [Pytest fixtures][fixtures].

<!--more-->

For one, `time_machine`'s control of the system clock does not apply to fixture
functions included in a test's signature.

E.g. this test will fail:

```python
@pytest.fixture
def now():
    return datetime.datetime.now()

@time_machine.travel("2020-06-10T14:00")
def test_now_fixture(now):
    # The date of the injected value isn't controlled by `time_machine` so this
    # assertion will fail.
    assert now.date() == datetime.date(2020, 6, 10)
```

Further, you can't fix this test by also wrapping the `now` function with
`@time_machine`:

```python
@time_machine.travel("2020-06-10T14:00")
@pytest.fixture
def now():
    return datetime.datetime.now()

@time_machine.travel("2020-06-10T14:00")
def test_now_fixture(now):
    # The date of the injected value STILL isn't controlled by `time_machine` so
    # this assertion will fail again.
    assert now.date() == datetime.date(2020, 6, 10)
```

That's a bit surprising.

But the test does pass if you re-order the decorators to ensure
`@pytest.fixture` is outermost:

```python
@pytest.fixture
@time_machine.travel("2020-06-10T14:00")
def now():
    return datetime.datetime.now()

@time_machine.travel("2020-06-10T14:00")
def test_now_fixture(now):
    # The date of the injected value is now controlled by `time_machine` so
    # this assertion will pass.
    assert now.date() == datetime.date(2020, 6, 10)
```

These are contrived examples but illustrate the point.

## Don't use fixtures to create test objects

In general, I would avoid using Pytest fixtures to create test objects. The are
indirect, suffer from gotchas such as the above, and generally make tests harder
to understand and maintain.

Better to explicitly create the objects you need in the test body itself; using
factories or builders if necessary.

If you do really want to use Pytest fixtures for set-up, prefer to inject
_factories_ instead, that aren't executed until the test body is run.

```python
@pytest.fixture
def now_fn():
    # Return a datetime factory function, not the datetime itself.
    return datetime.datetime.now

@time_machine.travel("2020-06-10T14:00")
def test_now_fixture(now_fn):
    now = now_fn()
    # Since the clock was called within the test body, the expected date was
    # returned.
    assert now.date() == datetime.date(2020, 6, 10)
```

[time_machine]: https://github.com/adamchainz/time-machine
[fixtures]: https://docs.pytest.org/en/6.2.x/fixture.html
