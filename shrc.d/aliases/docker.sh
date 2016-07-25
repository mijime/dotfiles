#!/bin/bash

# ------------------------------------
# Docker alias and function
# ------------------------------------

alias dmachine='docker-machine'
alias dcompose='docker-compose'

dclean(){
  # xargs_opt=--no-run-if-empty
  docker ps -aq | xargs ${xargs_opt} docker rm 2>/dev/null | sed 's/^/container: /g'
  docker images | awk '/<none>/{print$3}' | xargs ${xargs_opt} docker rmi 2>/dev/null | sed 's/^/image: /g'
  docker volume ls -q | xargs ${xargs_opt} docker volume rm 2>/dev/null | sed 's/^/volume: /g'
  docker network ls -q | xargs ${xargs_opt} docker network rm 2>/dev/null | sed 's/^/network: /g'
}

alias dip='docker inspect --format "{{.Name}} {{.Config.Image}} {{.NetworkSettings.IPAddress}}/{{.NetworkSettings.IPPrefixLen}}"'
alias drund='docker run --detach'
alias druni='docker run --interactive --tty --rm'
alias dattach="docker attach"
alias dbuild="docker build"
alias dcommit="docker commit"
alias dcp="docker cp"
alias dcreate="docker create"
alias ddeploy="docker deploy"
alias ddiff="docker diff"
alias devents="docker events"
alias dexec="docker exec"
alias dexport="docker export"
alias dhistory="docker history"
alias dimages="docker images"
alias dimport="docker import"
alias dinfo="docker info"
alias dinspect="docker inspect"
alias dkill="docker kill"
alias dload="docker load"
alias dlogin="docker login"
alias dlogout="docker logout"
alias dlogs="docker logs"
alias dnetwork="docker network"
alias dnode="docker node"
alias dpause="docker pause"
alias dplugin="docker plugin"
alias dport="docker port"
alias dps="docker ps"
alias dpull="docker pull"
alias dpush="docker push"
alias drename="docker rename"
alias drestart="docker restart"
alias drm="docker rm"
alias drmi="docker rmi"
alias drun="docker run"
alias dsave="docker save"
alias dsearch="docker search"
alias dservice="docker service"
alias dstack="docker stack"
alias dstart="docker start"
alias dstats="docker stats"
alias dstop="docker stop"
alias dswarm="docker swarm"
alias dtag="docker tag"
alias dtop="docker top"
alias dunpause="docker unpause"
alias dupdate="docker update"
alias dversion="docker version"
alias dvolume="docker volume"
alias dwait="docker wait"
