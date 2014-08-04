# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.omnibus.chef_version = :latest
	config.vm.box = "hashicorp/precise64"

	config.ssh.forward_agent = true

	config.vm.network :private_network, ip: "192.168.23.4"

	config.vm.synced_folder 'vhost-root', '/var/www/typo3.neos', create: 'true', type: 'nfs'

	config.vm.provision :chef_solo do |chef|
		chef.cookbooks_path = [ "cookbooks", "site-cookbooks" ]
		chef.add_recipe "typo3-neos"

	end

	config.vm.provider "virtualbox" do |v|
		v.name = "TYPO3 Neos Site 001"
		v.customize ["modifyvm", :id, "--memory", "2048"]
		v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
	end
end
