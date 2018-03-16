name 'perficient_splunk'
maintainer 'Perficient Inc'
maintainer_email 'devops@perficient.com'
license 'CC BY'
description 'Installs/Configures splunk'
long_description 'Installs/Configures splunk'
version '0.1.6'
chef_version '>= 12.1' if respond_to?(:chef_version)

issues_url 'https://github.com/Perficient-DevOps/chef-perficient_splunk'
source_url 'https://github.com/Perficient-DevOps/chef-perficient_splunk'

depends 'chef-splunk'
