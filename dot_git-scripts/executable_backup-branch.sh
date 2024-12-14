#!/bin/bash

current_branch=$(git rev-parse --abbrev-ref HEAD)
base_branch="${current_branch%%--*}"

max_counter=0
for branch in $(git branch --list "${base_branch}--*"); do
  if [[ "$branch" =~ ${base_branch}--([0-9]+)$ ]]; then
    counter=${BASH_REMATCH[1]}
    if ((counter > max_counter)); then
      max_counter=$counter
    fi
  fi
done

next_counter=$((max_counter + 1))
next_branch="${base_branch}--${next_counter}"

git branch "${next_branch}"
echo "New branch '${next_branch}' created successfully."
