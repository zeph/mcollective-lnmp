#!/bin/sh

# skip if unnecessary...
rpm -qi puppetlabs-release-6-7 && exit 0
# http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html
rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm

# skip if unnecessary...
rpm -qi puppet && exit 0
# finally...
yum -y install puppet
