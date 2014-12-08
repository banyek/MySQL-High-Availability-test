#
#
# Setting up MySQL High Availibility demo environment
#
#

function setupReplUser {
	mysql -e "GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' IDENTIFIED BY 'repl';\G"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'manager'@'%' IDENTIFIED BY 'manager123';\G"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'manager'@'localhost' IDENTIFIED BY 'manager123';\G"
    mysql -e "GRANT USAGE ON *.* TO 'haproxy'@'%';"
	mysql -e "FLUSH PRIVILEGES;"
}

function setupRepl {
	HOST=$1
	ssh root@$HOST "mysql -e 'CHANGE MASTER TO MASTER_HOST=\"master1\", MASTER_USER=\"repl\", MASTER_PASSWORD=\"repl\", MASTER_AUTO_POSITION=1;'"
	ssh root@$HOST "mysql -e 'START SLAVE'"
}

function cloneDatabaseTo {
	HOST=$1
	ssh root@$HOST "/etc/init.d/mysql stop ; rm -rf /var/lib/mysql/*"
	innobackupex --compress --stream=xbstream ./ | ssh root@$HOST "xbstream -x -C /var/lib/mysql"
	ssh root@$HOST "chown -R mysql:mysql /var/lib/mysql"
	ssh root@$HOST "service mysql start"

}

setupReplUser
cloneDatabaseTo master2.dev
setupRepl master2.dev
cloneDatabaseTo slave.dev
setupRepl slave.dev
