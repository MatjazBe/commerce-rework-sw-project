#!/bin/bash

# This script sets everything up for modifying and effectively further developing the
# runtime environment; it integrates with VSCode and GIT and should be available in VSCode as a Task via:
#  "Tasks: Run Task" > "iqual Runtime Developer: On"

env $(sed '/^#/d' .env | xargs) git submodule foreach 'git checkout drupal-7.3'
sed -i 's/^\([^#]*ignore *= *dirty\)/#\1/' .gitmodules
if test -f ".vscode/settings.json"; then
    sed -i 's#^\([^/]*"git.ignoredRepositories".*\[".devcontainer"\],\?\)#//\1#' .vscode/settings.json
fi
if test -f "folders.code-workspace"; then
    sed -i 's#^\([^/]*"git.ignoredRepositories".*\[".devcontainer"\],\?\)#//\1#' folders.code-workspace
fi
