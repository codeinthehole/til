---
title: "Not to union Python list types"
date: "2023-01-28T11:21:10+00:00"
tags: ["Mypy", "Python"]
---

Consider this contrived function which either returns a list of tuples or a list
of dicts depending on an argument value:

```py
def f(q: str, return_dict: bool) -> list[tuple[Any, ...]] | list[dict[str, Any]]:
    if not q:
        return []
    if return_dict:
        return [{"a": 1, "b": 2}]
    return [(1, 2)]
```

Mypy (as of v0.991) complains about the empty list return value and the
hard-coded list of tuples:

```txt
Incompatible return value type (got "List[<nothing>]",
    expected "Union[List[Tuple[Any, ...]], List[Dict[str, Any]]]")  [return-value]
Incompatible return value type (got "List[Tuple[int, int]]",
    expected "Union[List[Tuple[Any, ...]], List[Dict[str, Any]]]")  [return-value]
```

Seems a bit odd.

Mypy can be placated by rewriting the return type as
`list[tuple[Any, ...], dict[str, Any]]` where the list item types are `Union`ed
instead.

```py
def f(q: str, return_dict: bool) -> list[tuple[Any, ...] | [dict[str, Any]]:
    if not q:
        return []
    if return_dict:
        return [{"a": 1, "b": 2}]
    return [(1, 2)]
```

The broader rule seems to be to avoid `Union`ing list types and prefer to
extract the list type and use the union for the list item type.

That is, prefer `list[X | Y]` over `list[X] | list[Y]`.

Will update this post when I understand the underlying cause (i.e. generics)
better.
