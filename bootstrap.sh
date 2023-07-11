#!/usr/bin/env bash

name=$(basename "$0")

usage() {
    cat << EOF
Usage: $0 [options]

Options:
    -f, --force
            Override the overwriting check.
    -s, --skip-post
            Skip the post processing step.
    -p, --pull
            Update dotfiles to latest.
    -d, --dry-run
            Show what would be done, without making any changes.
    -h, --help
            Print this message.
EOF
}

short=fspdh
long=force,skip-post,pull,dry-run,help
OPTIONS=$(getopt -o $short --long $long -n "$name"  -- "$@")

eval set -- "${OPTIONS}"
while :; do
    case "$1" in
        -f | --force)
            force="y"
            ;;
        -s | --skip-post)
            skip_post="y"
            ;;
        -p | --pull)
            run_pull="y"
            ;;
        -d | --dry-run)
            dry_run="--dry-run"
            ;;
        -h | --help)
            usage
            exit 0
            ;;
        *)
            break
            ;;
    esac
    shift
done
unset short long OPTIONS

cd "$(dirname "${BASH_SOURCE[0]}")" || return

if [ "$run_pull" == "y" ]; then
    git pull $dry_run
    if [ "$dry_run" == "" ]; then
        # git-submodule does not support dry run, just skip
        git submodule update
    fi
fi

do-it() {
    if [ "$dry_run" == "" ]; then
        rm -rf "$HOME/.config/nvim/after"
    fi

    rsync --exclude ".git" \
        --exclude ".gitmodules" \
        --exclude "after" \
        --exclude "bootstrap.sh" \
        --exclude "README.md" \
        --exclude "LICENSE" \
        -avh --no-perms $dry_run . ~

    # Post processing
    if [ "$skip_post" != "y" ] && [ "$dry_run" == "" ]; then
        source "$HOME/.bash_profile"
        nvim --headless "$HOME/.config/nvim/lua/plugins.lua" \
            -c 'so' \
            -c 'autocmd User PackerComplete quitall' \
            -c 'PackerSync'
        mkdir -p "$HOME/.local/bin"
        for editor in {vi,vim}; do
            if [ ! -f "$HOME/.local/bin/$editor" ]; then
                ln -s "$(which nvim)" "$HOME/.local/bin/$editor"
            fi
        done
    fi

    rsync --exclude ".git" \
        --exclude ".gitmodules" \
        --exclude "bootstrap.sh" \
        --exclude "README.md" \
        --exclude "LICENSE" \
        -avh --no-perms $dry_run . ~

    fc-cache -f
}

check-prerequisites() {
    which rg &> /dev/null || echo "[WARN] ripgrep is not installed!" 1>&2
    which tree-sitter &> /dev/null || echo "[WARN] tree-sitter is not installed!" 1>&2
}

if [ "$force" == "y" ]; then
    do-it
else
    check-prerequisites
    read -p "This may overwrite existing files in your home directory, continue anyway? (y/n) " -rn 1
    echo ""
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        do-it
    fi
fi

unset do-it check-prerequisites
unset name force skip_post dry_run run_pull
# vim:ts=4:sts=4
