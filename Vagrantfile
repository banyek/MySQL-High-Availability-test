# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "master1" do |master1|
    master1.vm.box = "base"
    master1.vm.network "private_network", ip: "192.168.50.10"
    master1.vm.hostname = "master1.dev"
    master1.vm.synced_folder "master1", "/vagrant"
    master1.vm.synced_folder "./files", "/etc/puppet/files"
    master1.vm.provision :puppet do |puppet|
     puppet.options = ["--fileserverconfig=/vagrant/fileserver.conf"]
     puppet.module_path = "modules"
    end
    master1.ssh.forward_agent
  end

config.vm.define "master2" do |master2|
    master2.vm.box = "base"
    master2.vm.network "private_network", ip: "192.168.50.11"
    master2.vm.hostname = "master2.dev"
    master2.vm.synced_folder "master2", "/vagrant"
    master2.vm.synced_folder "./files", "/etc/puppet/files"
    master2.vm.provision :puppet do |puppet|
      puppet.options = ["--fileserverconfig=/vagrant/fileserver.conf"]
     puppet.module_path = "modules"
    end
    master2.ssh.forward_agent
  end
  config.vm.define "slave" do |slave|
    slave.vm.box = "base"
    slave.vm.network "private_network", ip: "192.168.50.12"
    slave.vm.hostname = "slave.dev"
    slave.vm.synced_folder "slave", "/vagrant"
    slave.vm.synced_folder "./files", "/etc/puppet/files"
    slave.vm.provision :puppet do |puppet|
      puppet.options = ["--fileserverconfig=/vagrant/fileserver.conf"]
     puppet.module_path = "modules"
    end
    slave.ssh.forward_agent
  end

end
