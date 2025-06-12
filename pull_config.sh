#!/bin/bash

REPO_URL="git@github.com:DelicateChaos/arch-2025-dotfiles.git"
TARGET_DIR="$HOME/dotfiles"

refresh() {
    hyprctl reload
}

pull_dotfiles() {
    # Create directory if it doesn't exist
    echo "Attempting dotfiles configuration"
    if [ ! -d "$TARGET_DIR" ]; then
        echo "No dotfiles directory found, cloning custom config..."
        git clone "$REPO_URL" "$TARGET_DIR"
        
    else
        # If it's a git repo, ensure correct remote and optionally pull
        if [ -d "$TARGET_DIR/.git" ]; then
            cd "$TARGET_DIR"
            CURRENT_URL=$(git remote get-url origin)
            if [ "$CURRENT_URL" = "$REPO_URL" ]; then
                git pull origin $(git rev-parse --abbrev-ref HEAD)
                # Reloads the hyperctrl 
                refresh
            else
                echo "Dotfiles Directory exists with a different Git origin. Skipping."
            fi
        else
            echo "$TARGET_DIR exists but is not a Git repository. Skipping."
        fi
    fi
}

pull_dotfiles()
