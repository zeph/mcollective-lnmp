#!/bin/sh
#
# http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html
# http://www.rackspace.com/knowledge_center/article/installing-rhel-epel-repo-on-centos-5x-or-6x

dpkg --version
# KISS distro detector ;)
if [ $? -eq 0 ]; then
	# skip if unnecessary...
	dpkg -l puppetlabs-release && exit 0
	wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb && \
		dpkg -i puppetlabs-release-precise.deb && \
		apt-get update && apt-get -y install puppet
else
	# skip if unnecessary...
	rpm -qi puppetlabs-release || \
	rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm && \
		yum -y install puppet
	rpm -qi epel-release || \
	    rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
	rpm -qi remi-release || \
		rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm && \
		ls -1 /etc/yum.repos.d/epel* /etc/yum.repos.d/remi.repo
fi
