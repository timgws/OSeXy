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

echo "\nDownloading IE9 for Win7..."
curl -O -L "https://az412801.vo.msecnd.net/vhd/VMBuild_20141027/VMware/IE9/Mac/IE9.Win7.For.Mac.VMware.zipp"
echo "\nExtracting VM..."
extract_vm_and_cleanup

echo "\nDownloading IE11 for Windows 8.1..."
curl -O -L "https://az412801.vo.msecnd.net/vhd/VMBuild_20141027/VMware/IE11/Mac/IE11.Win8.1.For.Mac.VMware.zip"
echo "\nExtracting VM..."
extract_vm_and_cleanup

echo "\nVMs downloaded and extracted! Find them under $HOME/Downloads/modern.ie"
