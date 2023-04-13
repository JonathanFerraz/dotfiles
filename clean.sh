#!/usr/bin/env bash

# Kill node processes
killall node || true

# Remove brew artifacts
command -v brew >/dev/null 2>&1 && {
  brew cleanup
  brew prune
}

# Remove ubuntu artifacts
command -v apt-get >/dev/null 2>&1 && {
  sudo apt-get autoremove -y
  sudo apt-get autoclean -y
}

# Remove .DS_Store files
find $HOME -name '.DS_Store' -delete

# Remove downloads
rm -rf $HOME/Downloads/*

# Recursively delete `.DS_Store` files
# alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
# alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

echo "Cleaning completed successfully!"