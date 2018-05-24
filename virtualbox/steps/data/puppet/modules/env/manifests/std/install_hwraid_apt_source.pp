class env::std::install_hwraid_apt_source {

  include apt

  apt::source { 'hwraid.le-vert.net':
    key      => {
      'id'      => '6005210E23B3D3B4',
      'content' => template('env/std/hwraid/hwraid.le-vert.net.key.erb'),
    },
    comment  => 'Repo for megacli package',
    location => 'http://hwraid.le-vert.net/debian',
    release  => "${::lsbdistcodename}",
    repos    => 'main',
     include  => {
      'deb' => true,
      'src' => false
    }
   }
}
