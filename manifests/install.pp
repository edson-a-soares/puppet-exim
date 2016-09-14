class exim::install {

  # exec { "install-exim4":
  #    command => "sudo apt-get install --yes --force-yes exim4-daemon-light",
  #    path    => [ "/usr/bin", "/bin" ],
  # }

  package{ "exim4-daemon-light":
      ensure => present,
  } ->

  service{ "exim4":
      ensure => running,
      enable => true,
  }

}
