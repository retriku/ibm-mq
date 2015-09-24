# -*- mode: ruby -*-
# vi: set ft=ruby :

# Specify Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

# Create and configure the VM(s)
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = "docker-host"
  
  config.vm.network :private_network, type: "dhcp"
  #config.vm.network "private_network", ip: "192.168.55.10"
  config.vm.network :forwarded_port, host: 1414, guest: 1414

  config.vm.box_check_update = false

  config.ssh.insert_key = false

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "provision/", "/provision", disabled: false
  config.vm.synced_folder "data/", "/data", disabled:false

  config.vm.box = "phusion/ubuntu-14.04-amd64"

  config.vm.provision :shell, path: "provision/shell/setup.sh"

  config.vm.provision "docker" do |d|
    d.build_image "/provision/docker",
      args: "-t ibmimages/mqadvanced"
  end

  config.vm.provision :shell, path: "provision/shell/script.sh"
end
