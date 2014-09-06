#
# Cookbook:: typo3-neos
# Recipe:: default.rb
#
# Copyright 2013, Thomas Layh
#
# Version 0.1
#
# Install TYPO3 Neos + DevStuff

execute "apt-get update" do
	command "apt-get update"
end

include_recipe 'apache2'
['rewrite', 'deflate', 'php5', 'headers', 'expires', 'status', 'negotiation', 'setenvif'].each do |mod|
	include_recipe "apache2::mod_#{mod}"
end

include_recipe "php::package"
['apc', 'curl', 'gd', 'mysql', 'sqlite3'].each do |mod|
	include_recipe "php::module_#{mod}"
end

include_recipe 'mysql::server'
include_recipe 'git'
include_recipe 'typo3-neos::basic'

# setup host
cookbook_file "/etc/apache2/sites-available/typo3.neos" do
	source "typo3.neos"
	mode 0755
end

# prepare php.ini config
cookbook_file "/etc/php5/conf.d/php_dateTimeZone.ini" do
	source "php_dateTimeZone.ini"
	mode 0655
end
execute "restart apache" do
	command "/etc/init.d/apache2 reload"
end

cookbook_file "/etc/php5/conf.d/php_xdebug.ini" do
	source "php_xdebug.ini"
	mode 0655
end

cookbook_file "/etc/php5/conf.d/php_maxValues.ini" do
	source "php_maxValues.ini"
	mode 0655
end

# enable host and disable default host
apache_site "000-default" do
	enable false
end
apache_site "typo3.neos" do
	enable true
end

##############################
### CLONE AND INSTALL NEOS ###
##############################

execute "clone typo3.neos base 1/5" do
	command "git clone git://git.typo3.org/Neos/Distributions/Base.git /var/www/typo3.neos/tmp"
end
execute "clone typo3.neos base 2/5" do
	command "mv /var/www/typo3.neos/tmp/* /var/www/typo3.neos/"
end
execute "clone typo3.neos base 3/5" do
	command "mv /var/www/typo3.neos/tmp/.gitignore /var/www/typo3.neos/"
end
execute "clone typo3.neos base 4/5" do
	command "mv /var/www/typo3.neos/tmp/.git /var/www/typo3.neos/"
end
execute "clone typo3.neos base 5/5" do
	command "rmdir /var/www/typo3.neos/tmp"
end

execute "get composer" do
	command "curl -s https://getcomposer.org/installer | php"
	cwd "/var/www/typo3.neos"
end

execute "install TYPO3 Neos" do
	command "php composer.phar install --dev"
	cwd "/var/www/typo3.neos"
end

###############################
### FIXING FILE PERMISSIONS ###
###############################

execute 'Fix permissions' do
	command 'cd /var/www && chmod gu+w typo3.neos -R && chgrp www-data typo3.neos -R'
end

execute 'Set crazy file permissions so that we can use NFS' do
	command 'chmod -R 2777 /var/www/typo3.neos'
	#user 'vagrant'
	group 'www-data'
end

execute "fixing permissions" do
	command "Packages/Framework/TYPO3.Flow/Scripts/setfilepermissions.sh vagrant vagrant www-data"
	cwd "/var/www/typo3.neos/"
end
