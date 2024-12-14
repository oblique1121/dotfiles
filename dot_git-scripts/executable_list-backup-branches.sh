#!/bin/bash

current_branch=$(git rev-parse --abbrev-ref HEAD)

if [[ "$current_branch" =~ --([0-9]+)$ ]]; then
  base_branch="${current_branch%%--*}"
else
  base_branch="$current_branch"
fi

backup_branches=$(git branch --list "${base_branch}--*" | sed 's/^..//')

echo "Backup branches for base branch: $base_branch"
if [ -z "$backup_branches" ]; then
  echo "No backup branches found."
  exit 0
fi

if [[ "$current_branch" =~ --([0-9]+)$ ]]; then
  echo "$backup_branches" | while read -r branch; do
    if [ "$branch" = "$current_branch" ]; then
      echo "* $branch (current)"
    else
      echo "  $branch"
    fi
  done
else
  echo "$backup_branches"
fi
