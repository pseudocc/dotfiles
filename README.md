# pseudoc's dotfiles

This repository is inspired from
[Mathias's dotfile](https://github.com/mathiasbynens/dotfiles),
which is indeed a great repo.

The dotfiles that are stored here are suppose to serve for Linux.

## Appearance

My favorite terminal [Tabby](https://github.com/eugeny/tabby).

Install a [Nerd fonts](https://www.nerdfonts.com/font-downloads),
I am using the "CaskaydiaCove Nerd Font".

## Prerequisites

To get the best performace, install the followings.

- [ripgrep](https://github.com/BurntSushi/ripgrep)

```bash
sudo apt install ripgrep
```

- [tree-sitter](https://github.com/tree-sitter/tree-sitter)

```bash
cargo install tree-sitter-cli
```

- [npm](https://github.com/npm/cli)

```bash
sudo apt install npm
# recommands: also update node to lts
sudo npm install -g n
sudo n lts
# then update npm to latest
sudo npm install -g npm@latest
```

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
