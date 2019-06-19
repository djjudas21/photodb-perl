#!/bin/bash

if output=$(git status --porcelain) && [ -z "$output" ]; then
  # Working directory clean
  : #noop
else
  # Uncommitted changes
  git add -A .
  git commit -m "Automatic docs update"
  git push "https://${GH_TOKEN}@github.com/djjudas21/photodb.git"
fi
git stash apply
