# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.provider "virtualbox" do |v|
      v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/SHARE_NAME", "1"]
  end

  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "ubuntu/trusty64"
  config.vm.network :forwarded_port, guest: 4444, host: 4444
  config.vm.provision :shell, :path => "sh/provision.sh"
end
