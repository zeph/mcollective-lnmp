#!/bin/sh
# ref: http://www.rackspace.com/knowledge_center/article/installing-rhel-epel-repo-on-centos-5x-or-6x

# skip if unnecessary...
rpm -qi puppet && exit 0

# let's get the repo ref packages first
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sudo rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm

# then some simlinking
ls -1 /etc/yum.repos.d/epel* /etc/yum.repos.d/remi.repo

# finally...
yum -y install puppet
