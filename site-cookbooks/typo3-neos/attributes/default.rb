node.default['mysql']['server_root_password'] = 'root'
node.default['mysql']['server_debian_password'] = 'root'
node.default['mysql']['server_repl_password'] = 'root'
node.default['mysql']['bind_address'] = ''

include_attribute "apache2"
default["apache"]["default_site_enabled"] = false
