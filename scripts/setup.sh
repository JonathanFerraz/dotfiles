#!/bin/bash

# Ask for password
sudo -v

# dir of script 
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

# parent dir of that dir
BASEDIR="${DIR%/*}"

# Create .nvm directory if it doesn't exist

[ -d ~/.nvm ] || mkdir ~/.nvm

# Package managers & packages

. "$BASEDIR/homebrew/install.sh"
. "$BASEDIR/homebrew/brew_cask.sh"

# Registers zsh as a default shell
zsh_path=$(which zsh)

if [ -z `grep "$zsh_path" /etc/shells` ]; then
  echo "Path to Zsh: $zsh_path. Enter your password to change default shell:"
  grep -Fxq "$zsh_path" /etc/shells || sudo bash -c "echo $zsh_path >> /etc/shells"
  chsh -s "$zsh_path" $USER || echo "Cannot set zsh as default shell!"
fi

install_zsh () {
    if [ ! -d ~/.oh-my-zsh/ ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
    else
        echo "oh-my-zsh already installed"
    fi
}

install_spaceship_theme() {
    if [ ! -d ~/.oh-my-zsh/custom/themes/spaceship-prompt ]; then
        git clone https://github.com/spaceship-prompt/spaceship-prompt.git ~/.oh-my-zsh/custom/themes/spaceship-prompt --depth=1
        ln -s ~/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme
    else
        echo "spaceship theme already installed"
    fi
}

clone_zsh_packages () {
    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/ ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    else
        echo "zsh-autosuggestions already installed"
    fi

    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/ ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    else
        echo "zsh-syntax-highlighting already installed"
    fi
    
    if [ ! -d ~/.oh-my-zsh/custom/plugins/yarn-extra-completion/ ]; then
        git clone https://github.com/buonomo/yarn-extra-completion ~/.oh-my-zsh/custom/plugins/yarn-extra-completion
    else
        echo "yarn-extra-completion already installed"
    fi
}

install_zsh
install_spaceship_theme
clone_zsh_packages

ln -sfv "$BASEDIR/zsh/.zshrc" ~

echo "Dotfiles installed successfully! Please restart your terminal!"
