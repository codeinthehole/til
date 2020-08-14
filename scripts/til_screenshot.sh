#!/usr/bin/env bash
#
# Helper script to make it easy to capture a screenshot
# 
# Usage:
#
#   $ ./til_screenshot System preferences

set -eu -o pipefail

PROJECT_ROOT=$(dirname $(dirname "$0"))

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
    echo "Select portion of screen to copy"
    screencapture -i "$filepath"

    # Compress image
    pngcrush -ow "$filepath" 2> /dev/null

    # Store image markdown in system clipboard. We use the figure built-in shortcode (https://github.com/LukasJoswiak/etch/wiki/Shortcodes)
    filename=$(basename "$filepath")
    echo "{{< figure src=\"/images/$filename\" title=\"\" caption=\"\" alt=\"$description\" >}}" | pbcopy

    echo "Image markdown snippet added to clipboard"
}

function generate_image_filepath() {
    echo static/images/$(slugify "$1").png
}

if [[ $_ != $0 ]]
then
    if [ $# -eq 0 ]
    then
        echo "Please enter an image description" >&2
        exit 1
    else
        main "$*"
    fi
fi
