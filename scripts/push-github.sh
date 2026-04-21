#!/bin/bash
set -e

if [ ! -f .env ]; then
    echo "No existe el archivo .env"
    exit 1
fi

source .env

if [ -z "$GITHUB_REPO_URL" ]; then
    echo "Falta GITHUB_REPO_URL en el .env"
    exit 1
fi

if [ ! -d .git ]; then
    git init
fi

git add .

if ! git diff --cached --quiet; then
    git commit -m "update"
fi

git branch -M main

if ! git remote | grep -q origin; then
    git remote add origin "$GITHUB_REPO_URL"
fi

git push -u origin main
