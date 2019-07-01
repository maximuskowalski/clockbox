#!/bin/bash
#################################################################################
# Title:         Cloudbox: Max Clockbox Repo Cloner                                #
# Author(s):     Desimaniac (Original creator) & Migz93 (Community edition)     #
# URL:           https://github.com/maximuskowalski/clockbox                          #
# Description:   Clones Clockbox repo.                                         #
# --                                                                            #
#             Part of the Cloudbox project: https://cloudbox.works              #
#################################################################################
#                     GNU General Public License v3.0                           #
#################################################################################
# Usage:                                                                        #
# ======                                                                        #
# curl -s https://github.com/maximuskowalski/clockbox/mxcbrepo.sh | bash                       #
# wget -qO- https://github.com/maximuskowalski/clockbox/mxcbrepo.sh | bash                     #
#################################################################################


## Variables
CLOCKBOX_PATH="$HOME/clockbox"
CLOCKBOX_REPO="https://github.com/maximuskowalski/clockbox/clockbox.git"

## Clone Community and pull latest commit
if [ -d "$CLOCKBOX_PATH" ]; then
    if [ -d "$CLOCKBOX_PATH/.git" ]; then
        cd "$CLOCKBOX_PATH"
        git clean -df
        git pull
        git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)
        git submodule update --init --recursive
    else
        cd "$CLOCKBOX_PATH"
        git init
        git remote add origin "$CLOCKBOX_REPO"
        git fetch
        git branch master origin/master
        git checkout -f master
        git clean -df
        git pull
        git reset --hard origin/master
        git submodule update --init --recursive
    fi
else
    git clone "$CLOCKBOX_REPO" "$CLOCKBOX_PATH"
    cd "$CLOCKBOX_PATH"
    git submodule update --init --recursive
fi

## Copy settings and config files into clockbox folder
shopt -s nullglob
for i in "$CLOCKBOX_PATH"/defaults/*.default; do
    if [ ! -f "$CLOCKBOX_PATH/$(basename "${i%.*}")" ]; then
        cp -n "${i}" "$CLOCKBOX_PATH/$(basename "${i%.*}")"
    fi
done
shopt -u nullglob
