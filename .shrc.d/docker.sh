#!/bin/bash

# ------------------------------------
# Docker alias and function
# ------------------------------------

alias dmachine='docker-machine'
alias dcompose='docker-compose'

dclean(){
  # xargs_opt=--no-run-if-empty
  docker ps -aq | xargs ${xargs_opt} docker rm 2>/dev/null
  docker images | awk '/<none>/{print$3}' | xargs ${xargs_opt} docker rmi 2>/dev/null
}

alias dattach='docker attach'
alias dbuild='docker build'
alias dcommit='docker commit'
alias dcp='docker cp'
alias dcreate='docker create'
alias ddiff='docker diff'
alias devents='docker events'
alias dexec='docker exec'
alias dexecd='docker exec --detach'
alias dexeci='docker exec --interactive --tty'
alias dexport='docker export'
alias dhistory='docker history'
alias dimages='docker images'
alias dimport='docker import'
alias dinfo='docker info'
alias dinspect='docker inspect'
alias dip='docker inspect --format "{{.Name}} {{.Config.Image}} {{.NetworkSettings.IPAddress}}/{{.NetworkSettings.IPPrefixLen}}"'
alias dkill='docker kill'
alias dload='docker load'
alias dlogin='docker login'
alias dlogout='docker logout'
alias dlogs='docker logs'
alias dnetwork='docker network'
alias dpause='docker pause'
alias dport='docker port'
alias dps='docker ps'
alias dpull='docker pull'
alias dpush='docker push'
alias drename='docker rename'
alias drestart='docker restart'
alias drm='docker rm'
alias drmi='docker rmi'
alias drun='docker run'
alias drund='docker run --detach'
alias druni='docker run --interactive --tty --rm'
alias dsave='docker save'
alias dsearch='docker search'
alias dstart='docker start'
alias dstats='docker stats'
alias dstop='docker stop'
alias dtag='docker tag'
alias dtop='docker top'
alias dunpause='docker unpause'
alias dversion='docker version'
alias dvolume='docker volume'
alias dwait='docker wait'
