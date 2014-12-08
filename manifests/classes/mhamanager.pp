class mhamanager {

  package { "epel-release":
    provider  => rpm,
    source    => "http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm",
    ensure    => installed,
  } ->
  file { "/etc/yum.repos.d/epel.repo":
    source    => "puppet:///files/repos/epel.repo",
    owner     => "root",
    group     => "root",
    require   => Package["epel-release"]
  } ->
  package { "perl-Config-Tiny":
    ensure => installed,
    require => File['/etc/yum.repos.d/epel.repo'],
  } ->

  package { "perl-Log-Dispatch":
    ensure => installed
  } ->

  package { "perl-Parallel-ForkManager":
    ensure => installed,
    require => File['/etc/yum.repos.d/epel.repo'],
  } -> 
  package { "perl-Time-HiRes":
    ensure => installed,
    require => File['/etc/yum.repos.d/epel.repo'],
  } ->
  file { "/tmp/mha4mysql-manager-0.56-0.el6.noarch.rpm":
    ensure => present,
    source => 'puppet:///files/packages/mha4mysql-manager-0.56-0.el6.noarch.rpm',
  } ->
  package { "mha4mysql-manager":
    ensure   => 'installed',
    provider => rpm,
    source   => '/tmp/mha4mysql-manager-0.56-0.el6.noarch.rpm',
    require  => [ File['/tmp/mha4mysql-manager-0.56-0.el6.noarch.rpm'], Package['mha4mysql-node'] ], 
    } ->
  file { "/root/mha.conf":
    source   => "puppet:///files/mha/mha.conf",
  } ->
  package { "socat":
     ensure => installed
  }
  package { "haproxy":
    ensure => installed
  } ->
  file { "/etc/haproxy/haproxy.cfg":
    source => "puppet:///files/haproxy/haproxy.cfg"
  } ~>
  service { "haproxy":
    ensure => "running"
  }
}