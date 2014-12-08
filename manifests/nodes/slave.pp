node "slave.dev" {
  include common
  class { 'sql':
  	serverid => '3'
  }
  include mhamanager
}
