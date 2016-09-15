export FZF_IGNORE_FILTER="/\.git/\|/\.svn/\|/\.\?te\?mp/\|/\.\?cache/\|/logs\?/\|/node_modules/"
export FZF_DEFAULT_COMMAND="{ git ls-files || { ghq list --full-path & find . | grep -v \"${FZF_IGNORE_FILTER}\"; }; } 2>/dev/null"
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
