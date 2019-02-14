#!/usr/bin/env bash

set -ue


__noinstalled_package() {
  local brew_cmd=${*:-brew}
  {
    ${brew_cmd} list | awk '{print"brewlist",$0}'
    sed -e 's|#.*||' < /dev/stdin | awk '$1!=""{print"brewfile",$0}'
  } \
    | awk '$1=="brewlist"{p[$2]=1}$1=="brewfile"&&p[$2]!=1{print}' \
    | sed -e 's/brewfile//'
}

__noinstalled_package < "$(dirname "$0")/brewfile" | while read -r package
do brew install "${package}"
done
brew upgrade

__noinstalled_package brew cask < "$(dirname "$0")/brewfile-cask" | while read -r package
do brew cask install "${package}"
done
brew cask upgrade

brew cleanup
