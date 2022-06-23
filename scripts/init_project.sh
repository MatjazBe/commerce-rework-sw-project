#!/bin/bash

# Exit immediately on error
set -e


# Replace placeholders using environment variables
env $(sed '/^#/d' .env | xargs) sed '/^#/d;/^ *$/d;s/ *= */\
/' .env | while read variable; do
  read value
  if [ -z "$value" ]; then
    echo "Make sure you edit and fill out all environment variables in .env file!" 1>&2
    exit 12345
  fi
done
env $(sed '/^#/d' .env | xargs) sed '/^#/d;/^ *$/d;s/ *= */\
/' .env | while read variable; do
  read value
  printf "Replacing \$$variable with ${value}\n"
  # HACK: Using the -i flag with backup file works on linux and mac os
  (grep -rl "\$$variable" . || echo :) | xargs sed -i.sedhackbak "s#\$${variable}#${value}#g"
done

# UNHACK: Delete the backup files of the sed.
find . -name "*.sedhackbak" -type f -delete


# Clean-up composer create-project step
rm -rf vendor


# Initialize git repository
git init &&  git checkout -b main


# Init submodule dependency for given runtime
(export $(sed '/^#/d' .env | xargs) && git submodule add -b ${DEVCONTAINER_RUNTIME_BRANCH} --name devcontainer-runtime git@github.com:iqual-ch/devcontainer-runtime.git .devcontainer)


# Our first commit
mv composer.json .project-template-composer.json
git add . 
git commit . -m "Launching!"

# If an container_terminal_defaults.sh script is found, add it to our root's profile
terminal_defaults_file='/project/app/.container_terminal_defaults.rc'
touch ~/.bashrc
if [ -f "$terminal_defaults_file" ]; then
    if ! grep -q "bash $terminal_defaults_file" ~/.bashrc; then
        echo "bash $terminal_defaults_file" >> ~/.bashrc
    fi
fi
