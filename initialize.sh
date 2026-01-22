#!/usr/bin/env bash
set -e

#ask github username
read -rp "GitHub username: " GH_USER

#ask repository name ( defaults to directory name )
DEFAULT_REPO=$(basename "$PWD")
read -rp "Repository name [$DEFAULT_REPO]: " REPO_NAME
REPO_NAME=${REPO_NAME:-$DEFAULT_REPO}

#initialize git repository if not already initialized
if [ ! -d .git ]; then
    git init
fi

echo "✔ Git initialized."
echo "✔ Creating remote repository '${REPO_NAME}' under user '${GH_USER}'..."

git add .
git commit -m "Initial commit"
git branch -M main

#ask user to use ssh or https
read -rp "Use SSH? (y/n) [y]: " USE_SSH
USE_SSH=${USE_SSH:-y}
if [[ "$USE_SSH" =~ ^[Yy]$ ]]; then
    REMOTE="git@github.com:${GH_USER}/${REPO_NAME}.git"
else
    REMOTE="https://github.com/${GH_USER}/${REPO_NAME}.git"
fi

git remote add origin "$REMOTE"
git push -u origin main

echo "✔ Remote added:"
git remote -v
