#!/usr/bin/env bash

# Color-echo
# Prints colored, bold text.
# Based on https://gist.github.com/brandonb927/3195465

# Colors list
black='\033[0;30m'
white='\033[0;37m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'

# Bold
bold=`tput bold`

# Resets the style
normal=`tput sgr0`

# Color-echo.
# arg $1 = message
# arg $2 = Color
cecho() {
    echo "${2}${bold}==> ${1}${normal}"
    return
}
