#!/usr/bin/env bash

extract_vm_and_cleanup() {
    cat *.zip.00? > vm.zip
    rm *.zip.00?
    unzip vm.zip
    rm vm.zip
    return
}

cd "$HOME/Downloads"
mkdir "modern.ie"
cd "$HOME/Downloads/modern.ie"

echo "\nDownloading IE8 for WinXP..."
curl -O -L "https://www.modern.ie/vmdownload?browserOS=IE8-XP&parts=2&platform=Mac&virtPlatform=virtualbox&filename=VMBuild_20141027/VirtualBox/IE8/Mac/IE8.XP.For.Mac.VirtualBox.zip{.001,.002}"
echo "\nExtracting VM..."
extract_vm_and_cleanup

echo "\nDownloading IE9 for Win7..."
curl -O -L "https://www.modern.ie/vmdownload?browserOS=IE9-Win7&parts=4&platform=Mac&virtPlatform=virtualbox&filename=VMBuild_20141027/VirtualBox/IE9/Mac/IE9.Win7.For.Mac.VirtualBox.zip{.001,.002,.003,.004}"
echo "\nExtracting VM..."
extract_vm_and_cleanup

echo "\nDownloading IE10 for Win7..."
curl -O -L "https://www.modern.ie/vmdownload?browserOS=IE10-Win7&parts=4&platform=Mac&virtPlatform=virtualbox&filename=VMBuild_20141027/VirtualBox/IE10/Mac/IE10.Win7.For.Mac.VirtualBox.zip{.001,.002,.003,.004}"
echo "\nExtracting VM..."
extract_vm_and_cleanup

echo "\nVMs downloaded and extracted! Find them under $HOME/Downloads/modern.ie"
