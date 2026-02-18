#!/bin/bash
INPUT=$(cat)
MESSAGE=$(echo "$INPUT" | jq -r '.message // "Claude needs your attention"')
/opt/homebrew/bin/terminal-notifier \
  -title "Claude Code" \
  -message "$MESSAGE" \
  -sound "Hero"
exit 0
