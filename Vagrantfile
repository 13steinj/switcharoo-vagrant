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
  local: {},
  cpu: 4,
  dhcp: true,
  hostname: "switcharoo-vagrant",
  engine: "iojs-v1.2.0",
  nfs: true,
  smb: false,
  synced_dirs: {},
  path_to_base: false
}.merge(yml_config)

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.ssh.forward_agent = true
  
  config.vm.provider "virtualbox" do |vb|
    vb.customize [
      "modifyvm", :id,
      "--memory", user_config[:memory],
      "--cpus", user_config[:cpu]
    ]
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/SHARE_NAME", "1"]
  end

  config.vm.provider "kvm" do |kvm|
    kvm.core_number = user_config[:cpu]
    kvm.memory_size = user_config[:memory].to_s+"m"
  end

  config.vm.provider "vmware_fusion" do |v|
    v.vmx["numvcpus"] = user_config[:cpu]
    v.vmx["memsize"] = user_config[:memory]
  end

  config.vm.box = user_config[:box]
  config.vm.box_url = user_config[:box_url]

  if user_config[:nfs]
    config.vm.synced_folder ".", "/vagrant", type: "nfs"
  end

  if user_config[:dhcp]
    config.vm.network "private_network", type: 'dhcp'
  else
    config.vm.network "private_network", ip: user_config[:private_ip]
  end

  user_config[:synced_dirs].each do |key, value|
    if value
      config.vm.synced_folder value, '/host-raw/src/'+key, type: user_config[:nfs] && 'nfs' || user_config[:smb] && 'smb' || nil, mount_options:user_config[:nfs] && ['rw', 'vers=3', 'tcp', 'nolock'] || nil
      config.bindfs.bind_folder '/host-raw/src/'+key, '/host/src/'+key
    end
  end

  config.vm.network :forwarded_port, guest: 4444, host: 4444
  config.vm.provision :shell, :path => "sh/provision.sh", :args => [
    user_config[:local].keys.join(" "),
    user_config[:local].values.join(" "),
    user_config[:hostname],
    user_config[:engine],
    user_config[:path_to_base],
    user_config[:base_github_repo]
  ]
end
