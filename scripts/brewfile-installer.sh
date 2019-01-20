#!/usr/bin/env bash

set -ue


__noinstalled_package() {
  local brew_cmd=${@:-brew}
  {
    ${brew_cmd} list | awk '{print"brewlist",$0}'
    cat /dev/stdin | sed -e 's|#.*||' | awk '$1!=""{print"brewfile",$0}'
  } \
    | awk '$1=="brewlist"{p[$2]=1}$1=="brewfile"&&p[$2]!=1{print}' \
    | sed -e 's/brewfile//'
}

cat $(dirname $0)/brewfile | __noinstalled_package | while read package
do brew install ${package}
done
brew upgrade
brew cleanup

cat $(dirname $0)/brewfile-cask | __noinstalled_package brew cask | while read package
do brew cask install ${package}
done
brew cask upgrade

brew cleanup
