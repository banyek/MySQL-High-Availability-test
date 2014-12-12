node "slave.dev" {
  include common
  class { 'sql':
  	serverid => '3'
  }
  include mhamanager
  file { "/root/data.py":
    source => "puppet:///files/scripts/data.py",
    mode   => "0755"
  }
}
