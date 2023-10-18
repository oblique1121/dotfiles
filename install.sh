#!/bin/sh

sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply "$(dirname "$0")"
