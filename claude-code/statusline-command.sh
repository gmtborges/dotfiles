#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Parse session tokens from JSON
session_tokens=$(echo "$input" | jq -r '(.context_window.total_input_tokens // 0) + (.context_window.total_output_tokens // 0)')
session_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')

# Calculate session percentage and format as K
session_pct=$(echo "scale=1; ($session_tokens / $session_size) * 100" | bc 2>/dev/null || echo "0")
session_k=$(echo "scale=0; $session_tokens / 1000" | bc 2>/dev/null || echo "0")
size_k=$(echo "scale=0; $session_size / 1000" | bc 2>/dev/null || echo "0")

# Output the status line
printf "Context: %s%% (%sK/%sK)" "$session_pct" "$session_k" "$size_k"
