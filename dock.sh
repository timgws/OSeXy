#!/bin/sh
#
#    Copyright (c) 2015 Tim Groeneveld <tim@timg.ws> 
#
#    Permission is hereby granted, free of charge, to any person obtaining a copy
#    of this software and associated documentation files (the "Software"), to deal
#    in the Software without restriction, including without limitation the rights
#    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#    copies of the Software, and to permit persons to whom the Software is
#    furnished to do so, subject to the following conditions:
#
#    The above copyright notice and this permission notice shall be included in
#    all copies or substantial portions of the Software.
#
#    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#    THE SOFTWARE.
#
#

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
dock "MacVim"
dock "VMWare Fusion"
restart_dock
