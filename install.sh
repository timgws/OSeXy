#!/usr/bin/env bash

clear

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

# Includes color-echo
. "$DIR/functions/cecho.sh"

cecho "######################################################" $cyan
cecho "   Welcome to OSeXy! We will get your OSX turned on   " $cyan
cecho "   and ready for action. Keep in mind OSeXy is very   " $cyan
cecho "    opinionated and WILL change stuff in your Mac.    " $cyan
cecho "          CHECK THE SOURCE BEFORE CONTINUING          " $cyan
cecho "######################################################" $cyan

cecho "Did you read the above notice and want to continue? [y/n]" $magenta
read -r response
if [[ ! $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    cecho "Please come back when you are ready!" $red
    exit
fi

cecho "Good. Can I haz sudo?" $magenta
sudo -v

# Run a keep-alive to update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

cecho "STEP 1/5: Check for updates" $cyan
softwareupdate --verbose --install --all

cecho "STEP 2/5: Install Xcode command line tools" $cyan
cecho "(If a dialog shows up, press <Install>)" $green
xcode-select --install

cecho "STEP 3/5: Install homebrew and its counterparts" $cyan
. "$DIR/homebrew.sh"

cecho "STEP 4/5: Set sensitive OSX defaults" $cyan
cecho "This will change several of your OSX settings. Go ahead? [y/n]" $magenta
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    . "$DIR/osx.sh"
fi

cecho "STEP 5/5: Download Modern.IE Virtual Machines" $cyan
cecho "This may take a few hours, and you can always run modern.ie.sh manually later. Do it now? [y/n]" $magenta
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    . "$DIR/modern.ie.sh"
fi

cecho "Some changes will only take effect after rebooting. Do it now? [y/n]" $magenta
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    shutdown -r now "OSeXy finished last - rebooting..."
    exit
fi

cecho "We are done! Do not forget to reboot." $magenta
