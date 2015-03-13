#
#
# Setting up MySQL High Availibility demo environment
#
#

function setupReplUser {
	mysql -e "GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' IDENTIFIED BY 'repl';"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'manager'@'%' IDENTIFIED BY 'manager';"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'manager'@'localhost' IDENTIFIED BY 'manager';"
	mysql -e "GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO 'app'@'localhost' IDENTIFIED BY 'app';"
	mysql -e "GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO 'app'@'%' IDENTIFIED BY 'app';"
	mysql -e "FLUSH PRIVILEGES;"
}

function setupHaproxyMaster {
        mysql -e "SET SQL_LOG_BIN=0; GRANT ALL ON *.* TO 'haproxy_master'@'%';"
}

function setupHaproxySlave {
        HOST=$1
        ssh root@$HOST "mysql -e \"SET SQL_LOG_BIN=0; GRANT ALL ON *.* TO 'haproxy_slave'@'%';\""
}

function dropAnonymous {
        mysql -e "DELETE FROM mysql.user WHERE user='';"
        mysql -e "FLUSH PRIVILEGES;"
}

function setupData {
    mysql -e "CREATE TABLE test.user (id int(11) NOT NULL AUTO_INCREMENT,name varchar(20) DEFAULT NULL, PRIMARY KEY (id))"
}
function setupRepl {
	HOST=$1
	ssh root@$HOST "mysql -e 'CHANGE MASTER TO MASTER_HOST=\"master1\", MASTER_USER=\"repl\", MASTER_PASSWORD=\"repl\", MASTER_AUTO_POSITION=1;'"
	ssh root@$HOST "mysql -e 'START SLAVE'"
}

function cloneDatabaseTo {
	HOST=$1
	ssh root@$HOST "/etc/init.d/mysql stop ; rm -rf /var/lib/mysql/*"
	innobackupex --stream=xbstream ./ | ssh root@$HOST "xbstream -x -C /var/lib/mysql"
	ssh root@$HOST "chown -R mysql:mysql /var/lib/mysql"
	ssh root@$HOST "service mysql start"

}

setupReplUser
cloneDatabaseTo master2.dev
setupRepl master2.dev
cloneDatabaseTo slave.dev
setupRepl slave.dev
setupData
setupHaproxyMaster
setupHaproxySlave master2.dev
setupHaproxySlave slave.dev
dropAnonymous
