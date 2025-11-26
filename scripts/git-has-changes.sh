#!/usr/bin/env sh

if [ -n "$(git status --porcelain --untracked-files=no)" ]; then
  exit 1
fi
