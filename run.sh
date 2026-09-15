#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

filter=""
dry_run="0"

while [[ $# -gt 0 ]]; do
    # echo "ARG: \"$1\""
    if [[ "$1" == "--dry" ]]; then
        dry_run="1"
    else
        filter="$1"
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
scripts=()
while IFS= read -r s; do
    scripts+=("$s")
done < <(find "$script_dir/runs" -mindepth 1 -maxdepth 1 -type f -exec test -x {} \; -print | sort)

# If the directory is empty, notify the user
if [[ ${#scripts[@]} -eq 0 ]]; then
    log "No executable files found in $script_dir/runs, or try updating their permissions."
    exit 1
fi

# Narrow to the scripts whose filename contains the filter argument
if [[ -n "$filter" ]]; then
    matched=()
    for s in "${scripts[@]}"; do
        if [[ "$(basename "$s")" == *"$filter"* ]]; then
            matched+=("$s")
        fi
    done

    if [[ ${#matched[@]} -eq 0 ]]; then
        log "No scripts in $script_dir/runs match \"$filter\"."
        exit 1
    fi

    scripts=("${matched[@]}")
fi

# Iterate through executable scripts
for s in "${scripts[@]}"; do
    log "Running script: $s"

    if [[ $dry_run == "0" ]]; then
        "$s"
    fi
done

echo "Setup complete! Please restart your computer for all changes to take effect."
