#!/bin/bash

cd $(dirname $0)
H=$(pwd)/home

startask (){
printf 'Hi there!\n'
printf 'This script will install some configuration.\n'
printf 'Some files may be overwritten!\n'
printf 'Check the script before you run it!\n\n'
printf 'Ctrl+C to exit. Enter to continue.\n'
read -r
}

case $1 in
  "-f")sleep 0;;
  *)startask ;;
esac
set -e


echo "Checking dependencies."
checkcommand (){
  which $1 > /dev/null 2>&1 || { echo "Error: please install \"$1\"." && exit 1 ; }
}
for i in zsh nvim screen vifm;do checkcommand $i; done


echo "Processing configuration files."
mkdir -p ~/{.cache,.config,.local/{share,bin}}
rsync -av --del {$H,$HOME}/.config/vifm/
rsync -av --del {$H,$HOME}/.config/nvim/
rsync -av --del {$H,$HOME}/.local/share/ohmyzsh/
rsync -av --del {$H,$HOME}/.local/share/p10k/
rsync -av {$H,$HOME}/.local/bin/
rsync -av {$H,$HOME}/.p10k.zsh
rsync -av {$H,$HOME}/.zshrc

