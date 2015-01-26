#!/usr/bin/env bash

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    cecho "Installing homebrew..." $green
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    # CDs into brew directory
    cd `brew --prefix`
    
    cecho "Updating homebrew - adding remote..." $green
    git remote add origin https://github.com/Homebrew/homebrew.git
    
    cecho "Fetching origin..." $green
    git fetch origin
    
    cecho "Resetting HEAD..." $green
    git reset --hard origin/master    
fi

cecho "Updating homebrew recipes..." $green
brew update

# Workaround to loop through all taps. They can't be installed
# with brew tap x1 x2 x3 ..., they need to be ran individually
cecho "Installing taps..." $green
while read in; do brew tap "$in"; done < "$DIR/Tapfile"

cecho "Homebrew is installing formulas..." $green
brew install $(cat $DIR/Brewfile|grep -v "#")

# Updates the PATH for coreutils
PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

cecho "End of brew install. Cleaning up..." $green
brew cleanup

cecho "You now have the following formulas:" $green
brew list

cecho "Updating cask..." $green
brew cask update

cecho "Homebrew is installing casks..." $green
brew cask install $(cat $DIR/Caskfile|grep -v "#")

cecho "End of brew cask install. Cleaning up..." $green
brew cask cleanup

cecho "You now have the following casks:" $green
brew cask list
