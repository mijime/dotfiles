[[ -d ~/.sham ]] || git clone https://github.com/mijime/sham ~/.sham

source ~/.sham/dist/sham.sh
export SHAM_HOME=~/.sham/tmp/bash
export PATH=${PATH}:${SHAM_HOME}/bin

sham 'mijime/sham' dir: ~/.sham
sham 'mijime/dotfiles' dir: ~/.dotfiles of:'.shrc.d/*.sh shrc.d/*/*.{sh,bash}' use:'.bin/*'
sham 'junegunn/fzf' dir: ~/.fzf of:'shell/*.bash' use:'bin/*' do:'./install --bin'
sham 'benbc/cloud-formation-viz' use:'cfviz'
sham 'simonwhitaker/gibo' use:'gibo' of:'*.bash'
sham 'zquestz/s' use:'s'
sham 'mijime/merje' use:'merje'
sham load

[[ ! -f ~/.bashrc.local ]] || source ~/.bashrc.local
