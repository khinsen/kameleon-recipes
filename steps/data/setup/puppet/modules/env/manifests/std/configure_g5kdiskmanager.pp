class env::std::configure_g5kdiskmanager {

  require env::std::install_hwraid_apt_source
  require env::std::configure_g5kmanager

  case $operatingsystem {
    'Debian': {
      case "${::lsbdistcodename}" {
        "jessie", "stretch", "buster" : {
          file {
            '/etc/systemd/system/g5k-disk-manager.service':
              source => 'puppet:///modules/env/std/g5k-manager/g5k-disk-manager.service',
              ensure => file;
            '/usr/local/libexec/g5k-disk-manager':
              source => 'puppet:///modules/env/std/g5k-manager/g5k-disk-manager',
              mode => '0755',
              ensure => file;
            '/etc/systemd/system/multi-user.target.wants/g5k-disk-manager.service':
              ensure => link,
              target => '/etc/systemd/system/g5k-disk-manager.service';
          }
        }
        default : {
          err "${operatingsystem} not supported."
        }
      }
    }
    default : {
      err "${operatingsystem} not supported."
    }
  }
}

