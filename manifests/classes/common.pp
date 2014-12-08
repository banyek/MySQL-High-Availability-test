class common {
  # I don't want firewall on dev vagrant machines
  service { "iptables":
    ensure => stopped
  }

  file { "/etc/hosts":
    content => template('common/hosts.erb'),
  }
 
 file { "/root/.ssh":
    ensure => directory
 }

 file { "/root/.ssh/id_rsa":
    source => "puppet:///files/common/root/ssh/id_rsa",
    mode => "0600",
    owner => "root",
    group => "root",
    require => File['/root/.ssh']
 }

 file { "/root/.ssh/id_rsa.pub":
    source => "puppet:///files/common/root/ssh/id_rsa.pub",
    owner => "root",
    group => "root",
    require => File['/root/.ssh']
 }
 file { "/root/.ssh/authorized_keys":
    source => "puppet:///files/common/root/ssh/authorized_keys",
    owner => "root",
    group => "root",
    require => File['/root/.ssh']
 }
 file { "/root/.ssh/known_hosts":
 	source => "puppet:///files/common/root/ssh/known_hosts",
 	owner => "root",
    group => "root",
 	require => File['/root/.ssh']
 }
 file { "/root/.ssh/config":
   source => "puppet:///files/common/root/ssh/config",
 	owner => "root",
    group => "root",
 	require => File['/root/.ssh']
  } 
}



