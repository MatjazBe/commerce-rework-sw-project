#!/bin/bash

# This script sets everything up for 'ignoring' the source code (especially for GIT) for the
# runtime environment inside VSCode; it integrates with VSCode and GIT and should be available in VSCode as a Task via:
#  "Tasks: Run Task" > "iqual Runtime Developer: Off"
# After some development is done using the sister task "iqual Runtime Developer: On", one can use this task in order
# to 'hide away' the runtime environment from VSCode and make the DX easier.
#
# N.B.: You will probably need to reload the window to get the VSCode UI updated (Ctrl + Shift + P: "Developer: Reload Window")

env $(sed '/^#/d' .env | xargs) git submodule update --init
sed -i 's/^#\(.*ignore *= *dirty\)/\1/' .gitmodules
if test -f ".vscode/settings.json"; then
    sed -i 's#^//\([^/]*"git.ignoredRepositories".*\[".devcontainer"\],\?\)#\1#' .vscode/settings.json
fi
if test -f "folders.code-workspace"; then
    sed -i 's#^//\([^/]*"git.ignoredRepositories".*\[".devcontainer"\],\?\)#\1#' folders.code-workspace
fi

echo
echo "Please reload your VSCode to have effects applied (Ctrl + Shift + P: "Developer: Reload Window")"
