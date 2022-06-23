#!/bin/bash

# This script makes sure the checked-out state of the submodule is:
# (a) Tracking the defined branch (@see DEVCONTAINER_RUNTIME_BRANCH in .env)
# (b) Points to the fixed commit defined by the parent repository (i.e. the software project repo)

env $(sed '/^#/d' .env | xargs) git submodule foreach 'git checkout drupal-7.3 && git reset --hard $sha1'