#!/bin/bash

force_delete=false
while getopts ":f" opt; do
  case $opt in
  f)
    force_delete=true
    ;;
  *)
    echo "Usage: $0 [-f]"
    exit 1
    ;;
  esac
done

current_branch=$(git rev-parse --abbrev-ref HEAD)

if [[ "$current_branch" =~ --([0-9]+)$ ]]; then
  base_branch="${current_branch%%--*}"
  git switch "$base_branch" || {
    echo "Failed to switch to base branch: $base_branch"
    exit 1
  }
else
  base_branch="$current_branch"
fi

delete_command="git branch -d"
$force_delete && delete_command="git branch -D"

backup_branches=$(git branch --list "${base_branch}--*" | sed 's/^..//')
if [ -z "$backup_branches" ]; then
  echo "No backup branches found for base branch: $base_branch"
  exit 0
fi

echo "Deleting backup branches for base branch: $base_branch"
for branch in $backup_branches; do
  $delete_command "$branch"
done

echo "Cleanup completed."
