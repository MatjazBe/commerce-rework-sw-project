#!/bin/bash

# This is a helper script for updating the runtime environment to its fixed version
# as dictated by the parent git repo (where .gitmodules resides)

(env $(sed '/^#/d' .env | xargs) git submodule update | sed '/checked out/{q1}') || echo -e "Devcontainer updated! ${RED}Now would be a good time to rebuild your containers!${NC}"