#!/bin/sh

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply oblique1121/dotfiles
