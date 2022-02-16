---
title: "Factory boy can be used to build dicts"
date: "2021-09-30T13:56:48+01:00"
tags: ["FactoryBoy", "Python", "Testing"]
---

Conventionally subclasses of `factory.Factory` are used to build objects, often
Django models that are persisted to some data store.

But they can also be used to build plain `dict`s, which can be useful for
building complex `dict`s in tests.

This is done via the
[`Meta.model` field](https://factoryboy.readthedocs.io/en/stable/reference.html#factory.FactoryOptions.model)
which specifies the class of object to create. There's also a convenient
`factory.DictFactory` class.

Here's an example using `factory.Factory` subclasses to create a nested `dict`
fixture:

```py
import factory

class Pet(factory.DictFactory):
    species = "dog"
    name = "rover"


class Person(factory.DictFactory):
    name = "barry"
    age = 41
    pet = factory.SubFactory(Pet)
    has_pet_insurance = False

    class Meta:
        # Ensure dict field uses hyphens not underscores.
        rename = {"has_pet_insurance": "has-pet-insurance"}


def test_default_fields():
    assert Person() == {
        "name": "barry",
        "age": 41,
        "has-pet-insurance": False,
        "pet": {
            "species": "dog",
            "name": "rover"
        }
    }


def test_overriding_fields():
    assert Person(name="alan", pet__name="lassie") == {
        "name": "alan",
        "age": 41,
        "has-pet-insurance": False,
        "pet": {
            "species": "dog",
            "name": "lassie"
        }
    }


```
