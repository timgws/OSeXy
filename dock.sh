#!/bin/sh

clear_dock () {
    defaults write com.apple.dock persistent-apps -array
}

dock () {
    DIRECTORY="/Users/`whoami`/Applications/$1";
    full_dock "$DIRECTORY"
}

full_dock () {
    DIRECTORY="$1.app";
    XML="<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>${DIRECTORY}</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    defaults write com.apple.dock persistent-apps -array-add "$XML"
}

restart_dock() {
    killall -SIGHUP Dock
}

clear_dock
dock "Google Chrome"
dock "Firefox"
dock "GitHub"
full_dock "/Applications/MAMP/Sequel Pro"
dock "iTerm"
dock "Dash"
full_dock "/Applications/MAMP/MAMP"
dock "Skype"
dock "Spotify"
dock "PhpStorm"
dock "VMWare Fusion"
restart_dock
