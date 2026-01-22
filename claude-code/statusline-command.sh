#!/bin/bash

input=$(cat)

# Extract values using jq
MODEL_DISPLAY=$(echo "$input" | jq -r '.model.display_name')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir')

# Show git branch if in a git repo
GIT_BRANCH=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ -n "$BRANCH" ]; then
        GIT_BRANCH=" | $BRANCH"
    fi
fi

PERCENT_USED=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
USAGE=$(echo "$input" | jq '.context_window.current_usage')
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size')
CURRENT_TOKENS=$(echo "$USAGE" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')

# Round to K for readability
TOKENS_K=$(( (CURRENT_TOKENS + 500) / 1000 ))k
CONTEXT_K=$(( CONTEXT_SIZE / 1000 ))k

echo "[$MODEL_DISPLAY] | ${CURRENT_DIR##*/}$GIT_BRANCH | ${PERCENT_USED}% (${TOKENS_K}/${CONTEXT_K})"
