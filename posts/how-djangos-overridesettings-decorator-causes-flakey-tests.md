---
title: "How Django's `override_settings` decorator causes flakey tests"
date: "2022-11-13T17:09:21+00:00"
tags: ["Flakey tests", "Django", "Python", "Testing"]
---

This form can cause flakey tests:

```py
from django import forms
from django.conf import settings

class IceCreamForm(forms.Form):
     flavour = forms.ChoiceField(choices=settings.FLAVOURS)
```

The critical detail is that the `ChoiceField` choices are computed at
import-time using `settings`.

This can lead to flakiness if the above module is _first imported_ by a test
that uses Django's `override_settings` decorator to control the `FLAVOURS`
setting value. For example:

```py
from django.test import override_settings

@override_settings(FLAVOURS=["Strawberry"])
def test_create_ice_cream(client):
    # Perform some action that triggers the import of the above forms module.
    # Something like a HTTP request via Django's test client.
    response = client.get("/create-ice-cream/")
    ...
```

If this happens, the form field's choices will remain set to `["Strawberry"]`
for subsequent tests. This pollution can lead to later test failing if they
assume the form choices will be set to the default setting value.

Whether this happens or not depends on the order and grouping in which tests are
run, hence why it doesn't happen consistently. The grouping of tests can change
if you use parallelisation as via a tool like `pytest-xdist`.

## How to avoid?

Compute form choices at run-time, not import time.

This can be done by assigning choices in the forms `__init__` method:

```py
from django import forms
from django.conf import settings

class IceCreamForm(forms.Form):
     flavour = forms.ChoiceField()

     def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["flavour"].choices = settings.FLAVOURS
```

or, more concisely, by converting the `choices` value into a callable using a
`lambda`:

```py
from django import forms
from django.conf import settings

class IceCreamForm(forms.Form):
     flavour = forms.ChoiceField(choices=lambda: settings.FLAVOURS)
```

## Test pollution

More generally, try and minimise all forms of import-time computation,
especially expressions that reference Django's settings. Any such module-level
variable can be a source of test pollution, causing flakey tests.
