#
# Cookbook:: aws_splunk
# Recipe:: client
#
# Copyright:: 2018, The Authors, All Rights Reserved.

node.default[:splunk][:is_server] = false

### TODO:  hard-coding these two for now
directory '/opt/splunkforwarder' do
  action :create
end

link '/opt/splunk' do
  to '/opt/splunkforwarder'
  link_type :symbolic
  owner node[:splunk][:user][:username]
end
###

include_recipe 'chef-splunk::client'

### FIXME: This seems to only exist on the server...?
delete_resource( :template, "#{splunk_dir}/etc/apps/SplunkUniversalForwarder/default/limits.conf")
###

# Override the say the outputs are created to avoid using the server nodes
# fqdn which is not always valid, but use the cloud.public_ipv4 address instead.
# https://github.com/chef-cookbooks/chef-splunk/blob/master/recipes/client.rb#L33

splunk_servers = search(
  :node,
  "splunk_is_server:true AND chef_environment:#{node.chef_environment}"
).sort! do |a, b|
  a.name <=> b.name
end

# server_list = splunk_servers.map do |s|
#   "#{s['fqdn'] || s['ipaddress']}:#{s['splunk']['receiver_port']}"
# end.join(', ')

ip_server_list = splunk_servers.map do |s|
  "#{s[:cloud][:public_ipv4]}:#{s['splunk']['receiver_port']}"
end.join(', ')

# template "#{splunk_dir}/etc/system/local/outputs.conf" do
#   source 'outputs.conf.erb'
#   mode '644'
#   variables(
#     server_list: server_list,
#     outputs_conf: node['splunk']['outputs_conf']
#   )
#   notifies :restart, 'service[splunk]'
# end

edit_resource!(:template, "#{splunk_dir}/etc/system/local/outputs.conf") do
  source 'outputs.conf.erb'
  mode '644'
  variables(
    server_list: ip_server_list,
    outputs_conf: node['splunk']['outputs_conf']
  )
  notifies :restart, 'service[splunk]'
end
