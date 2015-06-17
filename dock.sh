#!/bin/sh

dock () {
    DIRECTORY="/Users/`whoami`/$1";
    XML="<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>${DIRECTORY}</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    defaults write com.apple.dock persistent-apps -array-add "$XML"
}

restart_dock() {
    killall -SIGHUP Dock
}

dock "Cyberduck.app"
dock "Dash.app"
dock "Firefox.app"
dock "Google Chrome.app"
dock "GitHub.app"
dock "HandBrake.app"
dock "Opera.app"
dock "RecordIt.app"
dock "VMWare Fusion.app"
dock "Spotify.app"
dock "Skype.app"
dock "Slack.app"
dock "PhpStorm.app"


