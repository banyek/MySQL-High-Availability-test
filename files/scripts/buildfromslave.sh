#!/bin/bash
ansible master1 -m shell -a "/root/build.sh"
ansible master1 -m shell -a "mysql -e 'set global read_only=0'"
echo "set server mysql/master1 weight 1" | socat /var/lib/haproxy/stats stdio
