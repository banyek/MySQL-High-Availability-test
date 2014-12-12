class sql ($serverid = '') {

  package { "percona-release":
    provider  => rpm,
    source    => "http://www.percona.com/downloads/percona-release/percona-release-0.0-1.x86_64.rpm",
    ensure    => installed,
  } ->
  package { "Percona-Server-shared-56":
    ensure => present,
    require => Package['percona-release']
  } -> 
  package { "Percona-Server-server-56":
    ensure  => present,
    require => Package['percona-release']
  } -> 
  package { "Percona-Server-client-56":
    ensure  => present,
    require => Package['percona-release']
  } ->
  package { "percona-toolkit":
    ensure  => present,
    require => Package['percona-release']
  } ->
  package { "percona-xtrabackup":
    ensure  => present,
    require => Package['percona-release']
  } ->

  file { "/etc/my.cnf":
    ensure => present,
    content => template('sql/my.cnf.erb'),
    notify  => Service['mysql']
  } -> 

  service { "mysql":
    ensure  => "running",
    require => Package['Percona-Server-server-56']
  } -> 
  file { "/tmp/mha4mysql-node-0.56-0.el6.noarch.rpm":
    ensure => present,
    source => 'puppet:///files/packages/mha4mysql-node-0.56-0.el6.noarch.rpm',
  } -> 
  package { "mha4mysql-node":
    ensure   => 'installed',
    provider => rpm,
    source   => '/tmp/mha4mysql-node-0.56-0.el6.noarch.rpm',
    require  => File['/tmp/mha4mysql-node-0.56-0.el6.noarch.rpm']
    }
  package {"MySQL-python":
    ensure   => 'installed'
  }
}
