name 'aws_splunk'
maintainer 'Perficient Inc'
maintainer_email 'devops@perficient.com'
license 'CC BY'
description 'Installs/Configures splunk'
long_description 'Installs/Configures splunk'
version '0.1.3'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/aws_splunk/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/aws_splunk'

depends 'chef-splunk'
