---
title: "About Django's `setup` method for generic view classes"
date: "2021-12-14T15:55:28+00:00"
tags: ["Django", "Python"]
---

Django 2.2 (released in April 2019)
[introduced a `setup` method](https://docs.djangoproject.com/en/3.2/releases/2.2/#generic-views)
to the `django.views.View` class, which is available to all generic views.

This is intended to be overridden to assign instance attributes that other
methods will need.

For example, you would use this to load model instances identified in the URL
arguments:

```py
from django.views import generic
from django import shortcuts
from myapp import models

class Frob(generic.TemplateView):

    def setup(self, request, *args, **kwargs):
        super().setup(request, *args, **kwargs)
        self.frob = shortcuts.get_object_or_404(models.Frob, pk=kwargs["pk"])
```

To date, I've been overriding `dispatch` to do this - didn't realise there was a
dedicated method.

More in the
[Django view docs](https://docs.djangoproject.com/en/2.2/ref/class-based-views/base/#django.views.generic.base.View.setup)
