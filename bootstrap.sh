#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" || return
git pull

function do-it() {
    rsync --exclude ".git/" \
          --exclude ".gitmodules" \
          --exclude "bootstrap.sh" \
          --exclude "README.md" \
          --exclude "LICENSE" \
          -avh --no-perms . ~
    source "$HOME/.bash_profile"

    for doc in $HOME/.vim/pack/git-plugins/start/*/doc; do
        vim -u NONE -c "helptags $doc" -c "q"
    done
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
    do-it
else
    read -p "This may overwrite existing files in your home directory, continue anyway? (y/n) " -rn 1
    echo ""
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        do-it
    fi
fi

unset do-it
# vim:ts=4:sts=4
