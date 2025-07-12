#!/bin/bash

cd "$(dirname "$0")"

# Autosave interval in seconds
AUTOSAVE_SECONDS=300

MODE="$1"

if [[ "${MODE,,}" == "force" ]]; then
    # Jump to commit section
    datetime=$(date "+%Y-%m-%d %H:%M:%S")
    
    git add .
    git commit -m "autosave $datetime"
    
    if git remote get-url origin >/dev/null 2>&1; then
        git push
    fi
    
    exit 0
fi

STAMPFILE="$(dirname "$0")/.last_autosave"
CURRENT_TS=$(date +%s)

LAST_TS=0
if [[ -f "$STAMPFILE" ]]; then
    LAST_TS=$(cat "$STAMPFILE")
fi

DELTA=$((CURRENT_TS - LAST_TS))

if [[ $DELTA -lt $AUTOSAVE_SECONDS ]]; then
    exit 0
fi

echo "$CURRENT_TS" > "$STAMPFILE"

datetime=$(date "+%Y-%m-%d %H:%M:%S")

git add .
git commit -m "autosave $datetime"

if git remote get-url origin >/dev/null 2>&1; then
    git push
fi