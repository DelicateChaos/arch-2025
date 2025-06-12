#!/bin/bash


REPO_URL="git@github.com:DelicateChaos/arch-2025-dotfiles.git"
TARGET_DIR="$HOME/dotfiles"

push_dotfiles() {
    cd "$TARGET_DIR"
    git add .
    git commit -m "Updated Config"
    git push
}