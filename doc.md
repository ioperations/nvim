# NVCode

## Install in one command

The following will install this config if you have an existing config it will move it to `~/.config/nvim.old`

This script only supports Mac, Debian and Arch

```
bash <(curl -s https://git.io/JTvvG)
```

## Install Neovim

- Mac

  ```
  brew install neovim

  brew install --HEAD neovim # Latest
  ```

- Debian

  ```
  sudo apt install neovim
  ```

- Arch

  ```
  sudo pacman -S neovim

  yay -S neovim-git # Latest
  ```

## Clone this repo into your config

```
git clone https://github.com/ioperations/nvim.git ~/.config/nvim
nvim +PlugInstall
```

## Install python & node support

```
pip3 install pynvim cmake-language-server
```

```
npm i -g neovim bash-language-server
```

## Install Neovim remote

```
pip3 install neovim-remote
```

This will install `nvr` to `~/.local/bin` so you will need to add the following to your `bashrc` or `zshrc`

```
export PATH=$HOME/go/bin:$HOME/.local/bin:$PATH
```

## Install clipboard support

- On Mac pbcopy should be builtin

- Debian

  ```
  sudo apt install xsel
  ```

- Arch

  ```
  sudo pacman -S xsel
  ```

## (Optional) Install python & node support using virtual environments

Make sure to add these paths somewhere in your config

```
let g:python3_host_prog = expand("<path to python with pynvim installed>")
let g:python3_host_prog = expand("~/.miniconda/envs/neovim/bin/python3.8") " <- example

let g:node_host_prog = expand("<path to node with neovim installed>")
let g:node_host_prog = expand("~/.nvm/versions/node/v12.16.1/bin/neovim-node-host") " <- example
```

## List of programs you should install

- ranger
- ueberzug
- ripgrep
- silver_searcher
- fd
- universal-ctags
- lazy git
- lazy docker
- ccls [ sudo apt install ccls #Debian ]

Explanations and installation instruction can be found on my blog

## Language Servers

Since CoC doesn't support all languages in there extensions
I recommend installing some language servers from scratch
and adding them to your `coc-settings.json` file

Example:

- bash

  `npm i -g bash-language-server`

  ```
  "languageserver": {
  "bash": {
    "command": "bash-language-server",
    "args": ["start"],
    "filetypes": ["sh"],
    "ignoredRootPaths": ["~"]
    }
  }
  ```

## For FAR to work

```
:UpdateRemotePlugins
```

## TabNine

To use TabNine enter the following in a buffer:

```
TabNine::config
```

**NOTE** This extension can take up a ton of memory

## Vim Gists

To use **vim-gists** you will need to configure the following:

```
git config --global github.user <username>
```

## CoC extensions to check out

- coc-fzf
- coc-stylelintplus
- coc-floaterm
- coc-actions
- coc-bookmark

