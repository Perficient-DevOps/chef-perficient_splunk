# aws_splunk

Wrapper cookbook to provide some updated defaults for how we will use the `chef-splunk` cookbook.

### Usage

Configure your roles and environments:

    knife role create splunk_server
    knife role create splunk_forwarder
    knife environment create splunk_dev
    knife environment create splunk_prod

Required the use of data vault for storing bootstrapping values otherwise it fails with HTTP 404 errors unceremoniously.

See https://github.com/chef-cookbooks/chef-splunk#usage

The cookbook is expected that you have a vault `splunk_<environment>`

    splunk_auth_info = chef_vault_item(:vault, "splunk_#{node.chef_environment}")['auth']

So to setup our specific example:

    knife vault create vault splunk_splunk-dev '{"id": "splunk_splunk-dev","auth": "admin:notarealpassword" }'  --search 'role:splunk*' --admins 'seanwilbur' --mode client
