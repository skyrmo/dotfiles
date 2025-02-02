#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

grep=""
dry_run="0"

while [[ $# -gt 0 ]]; do
    # echo "ARG: \"$1\""
    if [[ "$1" == "--dry" ]]; then
        dry_run="1"
    else
        grep="$1"
    fi
    shift
done

log() {
    if [[ $dry_run == "1" ]]; then
        echo "[DRY_RUN]: $1"
    else
        echo "$1"
    fi
}

# Find executable files
runs_dir=$(find "$script_dir/runs" -mindepth 1 -maxdepth 1 -type f -exec test -x {} \; -print | sort)

# If the directory is empty, notify the user
if [[ -z "$runs_dir" ]]; then
    log "No executable files found in $script_dir/runs, or try updating their permissions."
    exit 1
fi

# Iterate through executable scripts
for s in $runs_dir; do
    log "Running script: $s"

    if [[ $dry_run == "0" ]]; then
        "$s"
    fi
done

echo "Setup complete! Please restart your computer for all changes to take effect."
