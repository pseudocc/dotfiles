# pseudoc's dotfiles

This repository is inspired from
[Mathias's dotfile](https://github.com/mathiasbynens/dotfiles),
which is indeed a great repo.

The dotfiles that are stored here are suppose to serve for Linux.

## Install

Clone this repository recursively (git 2.13 or later),
```bash
git clone \
    --recurse-submodules \
    --shallow-submodules \
    -j8 git@github.com:pseudocc/dotfiles.git
```

then run the `bootstrap.sh`.
```bash
source dotfiles/bootstrap.sh
```
