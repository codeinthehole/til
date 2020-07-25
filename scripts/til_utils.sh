#!/usr/bin/env bash

# Echo a slugified version of the first argument.
function slugify() {
    echo "$1" | iconv -t ascii//TRANSLIT | sed -E 's/[^a-zA-Z0-9 ]+//g' | tr " " "-" | tr A-Z a-z 
}

