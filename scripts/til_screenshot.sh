#!/usr/bin/env bash
#
# Helper script to make it easy to capture a screenshot
# 
# Usage:
#
#   $ ./til_screenshot System preferences

set -eu -o pipefail

PROJECT_ROOT="$(dirname $(dirname "$0"))"

# Source functions
. $PROJECT_ROOT/scripts/til_utils.sh

function main() {
    cd "$PROJECT_ROOT"

    # Generate appropriate filename
    local description="$1"
    filepath=$(generate_image_filepath "$description")

    # Check filepath doesn't already exist
    if [ -f "$filepath" ]
    then
        echo "An image already exists with the description - please choose another" >&2
        exit 1
    fi

    # Capture image
    echo "Select portion of screen to copy" >&2
    screencapture -i "$filepath"

    # Shrink wide images so they are no wider than 700px.
    if [[ "$(identify -format "%w" "$filepath")" -gt 700 ]]
    then
        echo "Resizing to 700px wide" >&2
        mogrify -resize '700x' "$filepath" 
    fi

    # Compress image
    pngcrush -ow "$filepath" 2> /dev/null

    # Store image markdown in system clipboard. We use the built-in `figure` shortcode (https://github.com/LukasJoswiak/etch/wiki/Shortcodes)
    filename=$(basename "$filepath")
    echo "{{< figure src=\"/images/$filename\" link=\"/images/$filename\" title=\"\" caption=\"\" alt=\"$description\" >}}" | pbcopy

    echo "Image markdown snippet added to clipboard" >&2
}

function generate_image_filepath() {
    echo "static/images/$(slugify "$1").png"
}

if [[ $_ != "$0" ]]
then
    if [ $# -eq 0 ]
    then
        echo "Please enter an image description" >&2
        exit 1
    else
        main "$*"
    fi
fi
