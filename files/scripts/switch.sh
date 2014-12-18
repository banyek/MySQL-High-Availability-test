#!/bin/bash

masterha_master_switch --conf=mha.conf --master_state=alive --new_master_host=$1 --orig_master_is_new_slave --interactive=0
rm -f /etc/haproxy/haproxy.cfg
ln -s /etc/haproxy/haproxy.cfg_$1 /etc/haproxy/haproxy.cfg
service haproxy reload
