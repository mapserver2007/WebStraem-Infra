# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # webstream-test
  config.vm.define "webstream-test" do |node|
    node.vm.box = "bento/centos-7.1"
    node.vm.hostname = "webstream-test"
    node.vm.network :public_network, ip: "192.168.0.205"
    node.vm.network :forwarded_port, guest: 22, host: 2231

    config.vm.provision :ansible do |ansible|
      ansible.playbook = "ansible/setup.yml"
      ansible.host_key_checking = false
    end
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 1024]
  end
end
