#!/bin/sh
#
# http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html

dpkg --version 2>&1> /dev/null
# KISS distro detector ;)
if [ $? -eq 0 ]; then
	# skip if unnecessary...
	dpkg -l puppetlabs-release 2>&1> /dev/null && exit 0
	wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb && \
		dpkg -i puppetlabs-release-precise.deb && \
		apt-get update && apt-get -y install puppet
else
	# skip if unnecessary...
	rpm -qi puppetlabs-release 2>&1> /dev/null && exit 0
	rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm && \
		yum -y install puppet
fi
