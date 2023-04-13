# Install cask packages if they are missing
brew_install_cask() {
    if brew ls --cask --versions $app &>/dev/null; then
        echo "${app} is already installed"
    else
        echo "Installing ${app}" && brew install --cask $app && echo "${app} is installed"
    fi
}

apps=(
    google-chrome
    visual-studio-code
    fig
    postman
    rapidapi
    gitkraken
    discord
    figma
)

for app in "${apps[@]}"
do
    brew_install_cask "$app"
done