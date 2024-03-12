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
bash dotfiles/bootstrap.sh
```

## Nvim-dap

I do not find a way to fully automate this process,
I would like to write down some steps need manual interactions:

Open NeoVim, run `:Mason` open DAP page, and install the following ones:

- codelldb
- bash-debug-adapter

Open you terminal and install debugpy:

```sh
pip install debugpy
```

Before start debugging, run command like `nvim_dap rust` to generate
the dap configuration template, edit the file if needed and source
the file(`:so .nvim-dap.lua`).

Strike `<leader><C-d>` to start debugging.
