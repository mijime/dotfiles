#!/bin/bash

# ------------------------------------
# Docker alias and function
# ------------------------------------

alias dbuild='docker build'

alias dexec='docker exec'

alias dexeci='docker exec --interactive --tty'

alias dimages='docker images'

alias dkill='docker kill'

alias dlogs='docker logs'

alias dps='docker ps'

alias dpull='docker pull'

alias dpush='docker push'

alias drm='docker rm'

alias drmi='docker rmi'

alias drun='docker run'

alias druni='docker run --interactive --tty --rm'

alias drund='docker run --detach'

alias dstart='docker start'

alias dstop='docker stop'

alias drestart='docker restart'

alias dtag='docker tag'

alias dtop='docker top'

alias dip='docker ps -q | xargs --no-run-if-empty docker inspect --format "{{.Id}} {{.NetworkSettings.IPAddress}}"'

alias dcompose='docker-compose'

alias dmachine='docker-machine'

dclean(){
  xargs_opt=--no-run-if-empty
  docker ps -aq | xargs ${xargs_opt} docker rm 2>/dev/null
  docker images | awk '/<none>/{print$3}' | xargs ${xargs_opt} docker rmi 2>/dev/null
}

dlt(){
  echo "localhost:5000/${USER}/$(pwd|xargs basename):$(date +%F)"
}
