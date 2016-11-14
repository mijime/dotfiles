#!/usr/bin/bash

_fzf_complete_docker() {
  _fzf_complete '+m --ansi' "$@" < <(
  docker ps -a  | awk 'NR>1{print"[C]",$0}'
  docker images | awk 'NR>1{print"[I]",$0}'
  )
}
_fzf_complete_docker_post() {
  awk '$1=="[I]"&&/<none>/{print$4;next}$1=="[I]"{print$2":"$3}$1=="[C]"{print$NF}'
}
complete -F _fzf_complete_docker docker

_fzf_complete_docker-compose() {
  _fzf_complete '+m --ansi' "$@" < <(
  docker-compose config --services 2>/dev/null
  )
}
complete -F _fzf_complete_docker-compose docker-compose

_fzf_complete_git() {
  _fzf_complete '+m --ansi' "$@" < <(
  git status --short | sed -e 's/^/[S] /g'
  git branch --color=always --all | sed -e 's/^/[B] /g'
  git log --color=always --date=relative --abbrev-commit --all \
    --pretty='%C(red)%h %C(reset)%s%C(yellow)%d %C(green)(%cr) %C(blue)<%an>%C(reset)' | sed -e 's/^/[L] /g'
  )
}
_fzf_complete_git_post() {
  awk '$1=="[S]"||$1=="[B]"{print$NF}$1=="[L]"{print$2}'
}
complete -F _fzf_complete_git git
