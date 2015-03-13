USAGE
=====

How to use this environment.

Application
-----------

The whole system can be managed on slave host. There is a small script (data.py) which is simulates a working web application: it writing data to master database and reads it back from the slave. You can run it on slave host. 
```
banyek@bodhisattva ~/W/g/MySQL-High-Availability-test (master)> vagrant ssh slave
Welcome to your Vagrant-built virtual machine.
[vagrant@slave ~]$ sudo /root/data.py
Write: Success
Read: 1
Write: Success
Read: 2
Write: Success
Read: 3
Write: Success
```

Failover
--------

There is two scripts, named failover_mha and failover_ansible which  manage the database failover part. They takes one parameter, the host to switch. 

```
[vagrant@slave ~]$ sudo /root/failover_mha master2
[...]
It is better to execute FLUSH NO_WRITE_TO_BINLOG TABLES on the master before switching. Is it ok to execute on master1(192.168.50.10:3306)? (YES/no):yes
[...]
From:
master1(192.168.50.10:3306) (current master)
 +--master2(192.168.50.11:3306)
 +--slave(127.0.0.1:3306)

To:
master2(192.168.50.11:3306) (new master)
 +--slave(127.0.0.1:3306)
 +--master1(192.168.50.10:3306)

Starting master switch from master1(192.168.50.10:3306) to master2(192.168.50.11:3306)? (yes/NO):yes
[...]
Mon Dec 15 11:49:20 2014 - [info]   /root/master_ip_online_change --command=stop --orig_master_host=master1 --orig_master_ip=192.168.50.10 --orig_master_port=3306 --orig_master_user='manager' --orig_master_password='manager' --new_master_host=master2 --new_master_ip=192.168.50.11 --new_master_port=3306 --new_master_user='manager' --new_master_password='manager' --orig_master_ssh_user=root --new_master_ssh_user=root   --orig_master_is_new_slave
[...]
[vagrant@slave ~]$ 
```
You can switch back with 
```
[vagrant@slave ~]$ sudo /root/failover_mha master1
```

During the failover part you can see that the database writes are stopped and resumed:
```
Write: Success
Read: 370
Write: Success
Read: 372
Write:Database is read only
Read: 372
Write:Database is read only
Read: 372
Write:Database is read only
Read: 372
Write:Database is read only
Read: 372
Write: Success
```

That's all. 


