# OSeXy
A script your OSX will be glad to call its first.

**OSeXy** is a bootstrap intended to be the very first script to be ran on a fresh OSX install. It will:

1. Check for system updates
2. Install Xcode command line tools
3. Install homebrew and several [formulas](https://github.com/timgws/OSeXy/blob/master/Brewfile) & [casks](https://github.com/timgws/OSeXy/blob/master/Caskfile)
4. Set [OSX sensitive defaults](https://github.com/timgws/OSeXy/blob/master/osx.sh)
5. Download and install [MAMP](https://www.mamp.info)
6. Rearange [all the items in your dock](https://github.com/timgws/OSeXy/blob/master/dock.sh)
7. Download IE8, IE9 and IE10 VMs from [modern.ie](https://www.modern.ie/en-us/virtualization-tools#downloads)

## How to use

Copy and paste the following code into the `Terminal` app on your Mac:

```bash
    ## Download OSeXy from Git/GitHub
    git clone git@github.com:timgws/OSeXy.git || \
        ( curl -o osexy.zip https://codeload.github.com/timgws/OSeXy/zip/master \
          && unzip osexy.zip )
    cd OSeXy*
    
    ## Run Installer
    sh install.sh
```

## Disclaimer

    TL;DR
    ----------
    
    This script is designed to be run on a new, fresh, cleanly installed Mac.
    
    Not doing so may have unintended consiquences.
    
    This script will clear your Dock, and may change a handful of settings.

OSeXy is a WIP personal project, hence it's very opinionated, poorly tested and incomplete. I'll improve it over time, but maybe you can find one or two niceties on how I tackle OSX bootstrapping.

Please check the source before using it.

This repository has been forked from [João Cunha](https://github.com/joaocunha)'s original OSeXy, mainly because we are different human beings, with different highlighting tastes, and I own VMWare/MS Office licenses!

## OS X releases supported by OSeXy

* OS X 10.10.3 (Yosemite)
* OS X 10.10.1 (Yosemite)

Currently only Yosemite is supported, however, newer releases should have support, too.

## Credits
Inspired by the work of these fine gentlemen:

* [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
* [Matthew Mueller](http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac)
* [Zeno Rocha](https://gist.github.com/zenorocha/7159780)
* [Ahmed El Gabri](https://github.com/ahmedelgabri/dotfiles)
* [Ben Alman](https://github.com/cowboy/dotfiles)
* [Brandon Brown](https://gist.github.com/brandonb927/3195465)
* [Eduardo Lundgren](https://github.com/eduardolundgren/dotfiles)
* [Jonas Rosland](https://github.com/virtualswede/osx-bootstrap)
