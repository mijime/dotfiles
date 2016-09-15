#!/usr/bin/zsh

if type _fzf_complete >/dev/null 2>/dev/null
then
  _fzf_complete_docker() {
    _fzf_complete '+m' "$@" < <(
    {
      docker ps -a | awk 'NR>1{print"[C]",$1,$2,$NF}'
      docker images | awk 'NR>1{print"[I]",$3,$1":"$2}'
    }
    )
  }

  _fzf_complete_docker_post() {
    awk '{print$2}'
  }

  _fzf_complete_docker-compose() {
    _fzf_complete '+m' "$@" < <(
      docker-compose config --services
    )
  }

  _fzf_complete_git() {
    _fzf_complete '+m' "$@" < <(
    {
      git status --short | awk '{print$2,$1}' | sed 's/^/[S] /g'
      git branch | awk '{print$2,$1}' | sed 's/^/[B] /g'
      git log --date=relative --abbrev-commit --oneline | sed 's/^/[L] /g'
    }
    )
  }
  _fzf_complete_git_post() {
    awk '{print$2}'
  }
fi
