node "master2.dev" {
  include common
  class { 'sql':
  	serverid => '2'
  }
}
