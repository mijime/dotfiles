[[ -d ~/.sham ]] || git clone https://github.com/mijime/sham ~/.sham

source ~/.sham/dist/sham.sh
export SHAM_HOME=~/.sham/tmp/bash
export PATH=${PATH}:${SHAM_HOME}/bin

sham 'mijime/sham' dir: ~/.sham
sham 'mijime/dotfiles' dir: ~/.dotfiles of:'shrc.d/*/*.{sh,bash}' use:'bin/*'
sham 'junegunn/fzf' dir: ~/.fzf of:'shell/*.bash' use:'bin/*' do:'./install --bin'
sham 'benbc/cloud-formation-viz' use:'cfviz'
sham 'simonwhitaker/gibo' use:'gibo' of:'*.bash'
sham 'sstephenson/bats' use:'bin/*'
sham 'mijime/.tools' use:'*'
sham load

if [[ -f ~/.dockerc ]]
then source ~/.dockerc
fi
if [[ -f ~/.bashrc.local ]]
then source ~/.bashrc.local
fi
