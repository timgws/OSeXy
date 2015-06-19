#!/usr/bin/env bash

clear

STEPS=5

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

# Includes color-echo
. "cecho.sh"

cecho "######################################################" $cyan
cecho "   Welcome to OSeXy! We will get your OSX turned on   " $cyan
cecho "   and ready for action. Keep in mind OSeXy is very   " $cyan
cecho "    opinionated and WILL change stuff in your Mac.    " $cyan
cecho "######################################################" $cyan
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

cecho "STEP 1/${STEPS}: Check for updates" $cyan
softwareupdate --verbose --install --all

cecho "STEP 2/${STEPS}: Install Xcode command line tools" $cyan
cecho "(If a dialog shows up, press <Install>)" $green
xcode-select --install

cecho "STEP 3/${STEPS}: Install homebrew and its counterparts" $cyan
. "$DIR/homebrew.sh"

cecho "STEP 4/${STEPS}: Set sensitive OSX defaults" $cyan
cecho "This will change several of your OSX settings. Go ahead? [y/n]" $magenta
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    . "$DIR/osx.sh"
fi

cecho "STEP 5/${STEPS}: Download Modern.IE Virtual Machines" $cyan
cecho "This may take a few hours, and you can always run modern.ie.sh manually later. Do it now? [y/n]" $magenta
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    . "$DIR/modern.ie.sh"
fi

. "$DIR/dock.sh"

cat > "/Users/`whoami`/Desktop/OSeXy Install Notes.txt" <<THIS
    GNU coreutils & bash 4 have been installed.

    All coreutils commands have been installed with the prefix 'g'.
    If you really need to use these commands with their normal names, you
    can add a "gnubin" directory to your PATH from your bashrc like:

        PATH="/usr/local/opt/coreutils/libexec/gnubin:\$PATH"

    Additionally, you can access their man pages with normal names if you add
    the "gnuman" directory to your MANPATH from your bashrc as well:

        MANPATH="/usr/local/opt/coreutils/libexec/gnubin:\$MANPATH"

    If you want to use Bash 4 as your login shell, it must be
    added to your /etc/shells file:

        /usr/local/bin/bash

THIS

cecho "Some changes will only take effect after rebooting. Do it now? [y/n]" $magenta
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    sudo shutdown -r now "OSeXy finished last - rebooting..."
    exit
fi

cecho "We are done! Do not forget to reboot." $magenta
