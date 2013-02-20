What?
=====

A quick way to get a mcollective network built for testing or evaluating MCollective.

The network will consist of a single node that acts as a middleware server using
Redis and a configurable amount of nodes under management.  On a 32GB machine I
have no problem running 26 machines using this repository.

This consists of a Vagrant file and a few **very** simple Puppet Modules that does the
simplest possible thing to get a MCollective setup going.

This setup uses Redis for the middleware, discovery and registration thus providing
a very light weight and fast setup.

This will setup the latest development MCollective along with the following plugins:

   * [Package Agent](https://github.com/puppetlabs/mcollective-package-agent)
   * [Service Agent](https://github.com/puppetlabs/mcollective-service-agent)
   * [Puppet Agent](https://github.com/puppetlabs/mcollective-puppet-agent)
   * [File Manager Agent](https://github.com/puppetlabs/mcollective-filemgr-agent)
   * [NRPE Agent](https://github.com/puppetlabs/mcollective-nrpe-agent)
   * [Process Agent](https://github.com/puppetlabs/mcollective-process-agent)
   * [Net Test Agent](https://github.com/puppetlabs/mcollective-nettest-agent)
   * [Request auditing](http://docs.puppetlabs.com/mcollective/simplerpc/auditing.html) enabled and logging to /var/log/mcollective-audit.log

NRPE is installed on all machines with checks *check_load*, *check_disks* and
*check_swap*

The nodes all have a fact called *cluster* which distributed them into a number
of groups so you can play with the mcollective filters.  See *mco facts cluster*.

Additionally there will be a simple Puppet Master deployed on the _middleware_ node
which as its site.pp will use the file in _deploy/modules/puppet/files/site.pp_.
By default all this does is sleep a random period, enough to be able to test and
demo the MCollective Puppet Agent

Setup?
------

Assuming you have a working Vagrant setup on your system it should be real simple
to get going:

    $ git clone git://github.com/ripienaar/mcollective-vagrant.git
    $ cd mcollective-vagrant

You should now edit the Vagrantfile and adjust the constants at the top to your
tastes:

    $ vi Vagrantfile
    $ vagrant up

Using?
------

### Verifying it works

    $ vagrant ssh middleware
    $ mco ping
    node0.example.net                        time=25.18 ms
    middleware.example.net                   time=26.50 ms

    ---- ping statistics ----
    2 replies max: 26.50 min: 25.18 avg: 25.84

### Using the package application

    $ mco package status mcollective

     * [ ============================================================> ] 2 / 2

            node0.example.net: mcollective-2.2.3-1.el6.noarch
       middleware.example.net: mcollective-2.2.3-1.el6.noarch

    Summary of Arch:

       noarch = 2

    Summary of Ensure:

       2.2.3-1.el6 = 2


    Finished processing 2 / 2 hosts in 523.95 ms

There are many more applications installed to help give you a feel for how things work.

Please read the [MCollective CLI Usage](http://docs.puppetlabs.com/mcollective/reference/basic/basic_cli_usage.html)
documentation to see how to discover what those commands are and how to interact with the
nodes you built.

Join #mcollective on Freenode if you have any questions

Modifying?
----------

The Puppet modules used to install the boxen are in the _deploy/modules_ directory.
The _mcollective_ module has _files/lib_ and everything in there will just be recursively
copied to the nodes.  So if you want to test some plugin you're working on just copy it
in there and run _vagrant provision_

The EPEL and Puppet Labs repositories are on the machines and all of the plugins mentioned
in the first section of this document are installed from there.  Some plugins though like
the Redis ones aren't yet available at Puppet Labs so for now they are deployed from the
module lib dir.

There is a package repo in _deploy/packages_ with some dependencies and this repo is
added to all the nodes, so if you drop a new package in there just run _createrepo_ in
that directory and it would be available to all the machines.

I'd love to see the various things like the Puppet setup done using proper modules from
the forge so PRs would be appreciated

Contact?
--------
R.I.Pienaar / rip@devco.net / @ripienaar / http://devco.net/
