node "master1.dev" {
  include common
  class { 'sql':
  	serverid => '1'
  }
file { "/root/build.sh":
  source => "puppet:///files/scripts/build.sh",
  mode   => "0755"
 }
}
