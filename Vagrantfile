# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos-7"
  config.vm.network "private_network", type: "dhcp"

  config.vm.hostname = "work"

  config.vm.provision :shell, :path => ".dotfiles/install.sh"
  config.vm.provision :shell, :inline => <<EOF
EOF

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 512]
    # vb.customize ["modifyvm", :id, "--memory", 2048]
  end
end
