#!/bin/bash

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

installnodemac() {
  brew install lua
  brew install node
  brew install yarn
}

installnodedebian() {
  sudo apt install -y nodejs npm  ripgrep clang ccls golang
}

installnodearch() {
  sudo pacman -S --noconfirm nodejs npm ripgrep clang ccls lua ninja ccache haskell-language-server \
    ranger go
}

installnode() { \
  echo "Installing node..."
  [ "$(uname)" == "Darwin" ] && installnodemac
  [ -n "$(uname -a | grep -e 'Debian\|Ubuntu')" ] && installnodedebian
  [ -n "$(uname -a | grep -e 'arch')" ] && installnodearch
  [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && echo "Windows not currently supported"
  sudo npm i -g neovim
}

installpiponmac() { \
  sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3 get-pip.py
  rm get-pip.py
}

installpipondebian() { \
  sudo apt install python3-pip -y
}

installpiponarch() { \
  sudo pacman -S --noconfirm python-pip
}

installpip() { \
  echo "Installing pip..."
  [ "$(uname)" == "Darwin" ] && installpiponmac
  [  -n "$(uname -a | grep -e 'Debian\|Ubuntu')" ] && installpipondebian
  [ -f "/etc/arch-release" ] && installpiponarch
  [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && echo "Windows not currently supported"
}

installpynvim() { \
  echo "Installing pynvim..."
  pip3 install pynvim neovim --user
}

installcocextensions() { \
  # Install extensions
  mkdir -p ~/.config/coc/extensions
  cd ~/.config/coc/extensions
  [ ! -f package.json ] && echo '{"dependencies":{}}'> package.json
  # Change extension names to the extensions you need
  # sudo npm install coc-explorer coc-snippets coc-json coc-actions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
  sudo npm install coc-explorer coc-snippets coc-json coc-actions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
}

cloneconfig() { \
  echo "Cloning Nvim Mach 2 configuration"
  [ -d ~/.config ] || mkdir ~/.config
  git clone https://github.com/ioperations/nvim.git ~/.config/nvim --depth 1
}

moveoldnvim() { \
  echo "Moving your config to nvim.old"
  mv $HOME/.config/nvim $HOME/.config/nvim.old
}

moveoldcoc() { \
  echo "Moving your coc to coc.old"
  mv $HOME/.config/coc $HOME/.config/coc.old
}

installplugins() { \
  mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.tmp
  mv $HOME/.config/nvim/utils/init.vim $HOME/.config/nvim/init.vim
  echo "Installing plugins..."
  nvim --headless +PlugInstall +qall
  mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/utils/init.vim
  mv $HOME/.config/nvim/init.vim.tmp $HOME/.config/nvim/init.vim
}

asktoinstallnode() { \
  echo "node not found"
  echo -n "Would you like to install node now (y/n)? "
  read answer
  [ "$answer" != "${answer#[Yy]}" ] && installnode && installcocextensions
}

asktoinstallpip() { \
  echo "pip not found"
  echo -n "Would you like to install pip now (y/n)? "
  read answer
  [ "$answer" != "${answer#[Yy]}" ] && installpip
}

installonmac() { \
  brew install ripgrep fzf ranger
}

pipinstallueberzug() { \
  which pip3 > /dev/null && pip3 install ueberzug || echo "Not installing ueberzug pip not found"
}

installondebian() { \
  sudo apt install ripgrep fzf ranger ruby ruby-dev gem libxext-dev -y
  sudo apt install zlib1g-dev python-dev python3-dev libxtst-dev -y
  sudo apt install ccls clangd -y
  sudo apt install texlive-extra-utils texlive-lang-chinese mupdf -y
  sudo npm install -g neovim bash-language-server dockerfile-language-server-nodejs
  sudo gem install solargraph
  sudo pip3 install ueberzug neovim-remote cmake-language-server "python-language-server[all]"
}


installonarch() { \
  sudo pacman -S install ripgrep fzf ranger
  which yay > /dev/null && yay -S python-ueberzug-git || pipinstallueberzug
  pip3 install neovim-remote
}

installextrapackages() { \
  [ "$(uname)" == "Darwin" ] && installonmac
  [  -n "$(uname -a | grep -e 'Debian\|Ubuntu')" ] && installondebian
  [ -f "/etc/arch-release" ] && installonarch
  [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && echo "Windows not currently supported"
}

# Welcome
echo 'Installing Nvim Mach 2'

# install pip
which pip3 > /dev/null && echo "pip installed, moving on..." || asktoinstallpip

# install node and neovim support
which node > /dev/null && echo "node installed, moving on..." || asktoinstallnode


# install pynvim
pip3 list | grep pynvim > /dev/null && echo "pynvim installed, moving on..." || installpynvim

# move old nvim directory if it exists
[ -d "$HOME/.config/nvim" ] && moveoldnvim

# move old nvim directory if it exists
[ -d "$HOME/.config/coc" ] && moveoldcoc

# clone config down
cloneconfig
# install plugins
which nvim > /dev/null && installplugins

installcocextensions

echo -n "Would you like to install these now?  (y/n)? "
read answer
[ "$answer" != "${answer#[Yy]}" ] && installextrapackages || echo "not installing extra packages"

