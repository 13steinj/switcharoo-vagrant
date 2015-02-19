# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

yml_config = {}
if File.exist?("vagrant_config.yml")
  yml_config = YAML::load_file("vagrant_config.yml")
end

user_config = {
  private_ip: "192.168.150.2",
  box: "ubuntu/trusty64",
  box_url: nil,
  forward_port: 4444,
  memory: 4096,
  local: [],
  cpu: 4,
  dhcp: true,
  hostname: "switcharoo-vagrant",
  engine: "v0.12.0",
  nfs: true,
  smb: false
}.merge(yml_config)

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.customize [
      "modifyvm", :id,
      "--memory", user_config[:memory],
      "--cpus", user_config[:cpu]
    ]
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/SHARE_NAME", "1"]
  end

  config.vm.box = user_config[:box]
  config.vm.box_url = user_config[:box_url]

  if user_config[:dhcp]
    config.vm.network "private_network", type: 'dhcp'
  else
    config.vm.network "private_network", ip: user_config[:private_ip]
  end

  config.vm.network :forwarded_port, guest: 4444, host: 4444
  config.vm.provision :shell, :path => "sh/provision.sh", :args => [
    user_config[:local].join(" "),
    user_config[:hostname],
    user_config[:engine]
  ]
end
