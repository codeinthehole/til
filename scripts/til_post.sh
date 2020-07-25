#!/usr/bin/env bash
# 
# Helper script to make it easy to write a TIL and publish it immediately.
#
# Usage:
#
#   $ ./til_post about Alfred's snippet collections

set -eu -o pipefail

PROJECT_ROOT=$(dirname $(dirname "$0"))

# Source functions
. $PROJECT_ROOT/scripts/til_utils.sh

function main() {
    # Change to this directory.
    cd "$PROJECT_ROOT"

    # Ensure repo is clean and on appropriate branch.
    if [[ ! -z $(git status --porcelain) ]]
    then
        echo "TIL repo has uncommitted changes. Commit these changes and try again" >&2
        exit 1
    fi
    git checkout master 2> /dev/null

    # Generate appropriate filepath
    local description="$1"
    filepath=$(generate_filepath "$description")

    # Open file pre-populated with Hugo frontmatter
    local title="$(tr '[:lower:]' '[:upper:]' <<< ${description:0:1})${description:1}"
    date=$(date +%Y-%m-%d)
    cat >"$filepath" <<- CONTENT
---
title: "$title"
date: "$date"
tags: []
---

CONTENT

    # Open Vim insert mode with the cursor after the frontmatter.
    vim -c ':normal }' -c 'startinsert' $filepath

    # Generate static site.
    publish "$filepath" "TIL $description"
}

function generate_filepath() {
    echo posts/$(slugify "$1").md
}

function publish() {
    local filepath="$1"
    local title="$2"

    # Commit the post file and any screenshots that might have been saved while writing this post.
    git add $filepath images/
    git commit -m "$title" > /dev/null 
}

if [[ $_ != $0 ]]
then
    if [ $# -eq 0 ]
    then
        echo "Please enter a TIL description" >&2
        exit 1
    else
        main "$*"
    fi
fi
