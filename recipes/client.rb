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
