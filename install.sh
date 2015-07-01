#!/usr/bin/env bash

STEPS=7

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

# Includes color-echo
. "cecho.sh"

OSXVERSION=`sw_vers -productVersion | sed -E 's/([0-9]*\.[0-9]*).*/\1/'`

if [ "$OSXVERSION" != "10.10" ]; then
    cecho "You must upgrade OS X to version 10.10 to use this installer!" $red
    cecho "Please go to the App Store, click on the upgrades tab" $cyan
    cecho "and get the latest version of the operating system" $cyan;
    echo;
    exit 2;
fi

clear

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
echo "Note: It might look like you are not entering your password";
echo "Just keep typing your user's password, and press enter.";
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

cecho "STEP 6/${STEPS}: Installing nodejs packages..." $cyan
while read in; do sudo npm install -g "$in"; done < "$DIR/npm"

cecho "STEP 7/${STEPS}: Grabbing server-config package..." $cyan
git clone https://github.com/timgws/server-config.git $HOME/.server-config
DFILES=$HOME/.server-config/dot-files;
cp $DFILES/.vimrc $HOME
cp $DFILES/.inputrc $HOME
cp $DFILES/.bash_profile $HOME
echo "source ~/.bashrc" > $HOME/.bash_profile
chmod +x $HOME/.bash_profile $HOME/.bashrc

GNUBIN=`brew --prefix coreutils`;

cat > "/Users/`whoami`/Desktop/OSeXy Install Notes.txt" <<THIS
    GNU coreutils & bash 4 have been installed.

    All coreutils commands have been installed with the prefix 'g'.
    If you really need to use these commands with their normal names, you
    can add a "gnubin" directory to your PATH from your bashrc like:

        PATH="$GNUBIN/libexec/gnubin:\$PATH"

    Additionally, you can access their man pages with normal names if you add
    the "gnuman" directory to your MANPATH from your bashrc as well:

        MANPATH="$GNUBIN/libexec/gnuman:\$MANPATH"

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
