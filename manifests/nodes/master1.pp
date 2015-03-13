node "master1.dev" {
  include common
  class { 'sql':
  	serverid => '1'
  }
file { "/root/build_mha.sh":
  source => "puppet:///files/scripts/build_mha.sh",
  mode   => "0755"
 }
file { "/root/build_ansible.sh":
  source => "puppet:///files/scripts/build_ansible.sh",
  mode   => "0755"
 }
}
