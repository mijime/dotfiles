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

for brewfile in "$(dirname "$0")/brewfile" "$(dirname "$0")/brewfile.local"
do
  if [[ ! -f ${brewfile} ]]
  then continue
  fi

  __noinstalled_package brew < "${brewfile}" | while read -r package
  do brew install "${package}"
  done
done
brew upgrade

for brewcaskfile in "$(dirname "$0")/brewfile-cask" "$(dirname "$0")/brewfile-cask.local"
do
  if [[ ! -f ${brewcaskfile} ]]
  then continue
  fi

  __noinstalled_package brew cask < "${brewcaskfile}" | while read -r package
  do brew cask install "${package}"
  done
done
brew cask upgrade

brew cleanup
