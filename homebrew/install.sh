#!/bin/bash

# Install Homebrew
if test ! $(which brew); then
  echo "-----> Installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
  eval "$(/opt/homebrew/bin/brew shellenv)"
else  
  echo "Homebrew already installed"
fi

brew update
brew upgrade

# Install packages if they are missing
brew_install() {
    if brew ls --versions $app &>/dev/null; then
        echo "${app} is already installed"
    else
        echo "installing ${app}" && brew install $app && echo "${app} is installed"
    fi
}

apps=(
    wget
    nvm
    yarn
    node
)

for app in "${apps[@]}"
do
    brew_install "$app"
done