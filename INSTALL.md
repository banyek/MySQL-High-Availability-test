Installation
============

Vagrant 
-------

To install Vagrant on your computer see the official vagrant guide on https://docs.vagrantup.com/v2/installation/


CentOS 6.4 box
--------------

I've built this demo on top of a Centos 6.4 image, which was found on vagrantbox.es.
After your vagrant installation is complete import the box to your system with the following commmand.
```
vagrant box add Centos-6.4 http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20131103.box
```

Bringing up virtual machines
----------------------------

Three boxes will be brought up, master1, master2, slave
Simply run 
```
vagrant up
```

All three machines will be boot up and gets provisioned via puppet.
There is a rare condition when puppet fails, if this happens you can run provisioner via
```
vagrant provision <boxname>
```
If the provision fails again, you have to reload the box, and run the provisioner again

```
vagrant reload <boxname>
vagrant provision <boxname>
```

Build up environment
--------------------

You have to log in to master1 and run as root the build script 
```
banyek@bodhisattva ~/W/g/MySQL-High-Availability-test (master)> vagrant ssh master1
Welcome to your Vagrant-built virtual machine.
[vagrant@master1 ~]$ sudo /root/build.sh
[...]
.. SUCCESS!
[vagrant@master1 ~]$
```

And finally, you have to remove the read-only flag from master database
```
[vagrant@master1 ~]$ sudo mysql -e "SET GLOBAL read_only=0;"
[vagrant@master1 ~]$
```

Your environment is up and running.








