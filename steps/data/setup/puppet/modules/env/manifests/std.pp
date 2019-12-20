# This file contains the 'std' class used to configure the standard environment to be executed in grid'5000.

class env::std ( $variant = "big", $parent_parameters = {} ){

  if $env::target_g5k {
    $root_pwd = lookup("env::std::misc::rootpwd")
  }
  else {
    $root_pwd = '$1$qzZwnZXQ$Ak1xs7Oma6HUHw/xDJ8q91' # grid5000
  }

  $std_parameters = {
    ganglia_enable => true,
    ntp_drift_file => true,
    misc_keep_tmp  => false,
    misc_root_pwd  => $root_pwd,
    mic_enable     => true,
  }

  $parameters = merge( $std_parameters, $parent_parameters )

  # Include big class
  class {
    'env::big':
      variant => $variant,
      parent_parameters => $parameters;
  }
  # OAR
  class { 'env::std::configure_oar_client': }
  # g5kchecks (+ ipmitool)
  class { 'env::std::install_g5kchecks': }
  # g5kcode
  class { 'env::std::add_g5kcode_to_path': }
  # g5k-subnets
  class { 'env::std::install_g5ksubnets': }
  # Log net access
  class { 'env::std::configure_rsyslog_remote': }
  # sudo-g5k
  class { 'env::std::install_sudog5k': }
  # g5k systemd generator
  class { 'env::std::g5k_generator': }
  # megacli (RAID controler)
  class { 'env::std::install_megacli': }
  # g5k-disk-manager
  class { 'env::std::configure_g5kdiskmanager': }
  # g5k-pmem-manager
  class { 'env::std::configure_g5kpmemmanager': }
  # disable lvm pvscan (bug 9453)
  class { 'env::std::disable_lvm_pvscan': }
}
