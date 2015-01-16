#!/bin/bash -e

yum_items=(
    vim nkf fuse-sshfs
    git gitflow
    sysstat psacct
)

pip_items=(
    awscli ansible fabric fig googlecl
)

gem_items=(
    bundler
)

golang_items=(
    github.com/docker/docker/docker
    github.com/peco/peco/cmd/peco
    github.com/mitchellh/gox
    github.com/tj/stack/cmd/stack
)

main(){
    install_yum_items
    install_pip_items
    install_gem_items
    install_golang_items
    setup_dotfiles
}

run_vagrant(){
    cat /dev/stdin | sudo -u vagrant sh
}

setup_dotfiles(){
    run_vagrant << EOF
    /vagrant/.dotfiles/setup.sh
EOF
}

install_yum_items(){
    yum -y groupinstall 'Development Tools'
    yum -y install epel-release
    yum -y install ${yum_items[@]}
    systemctl enable psacct
    systemctl start  psacct
}

install_pip_items(){
    yum -y install python-tools python-devel

    easy_install pip
    pip install --upgrade ${pip_items[@]}
}

install_gem_items(){
    yum -y install rubygems ruby-devel

    run_vagrant << EOF
    gem install ${gem_items[@]}
    cd /vagrant/.dotfiles && /usr/local/bin/bundler
EOF
}

install_golang_items(){
    yum -y install golang

    run_vagrant <<EOF
    for golang_item in ${golang_items[@]}
    do GOPATH=~/.go go get -v \$golang_item
    done
EOF
}

${*:-main}
