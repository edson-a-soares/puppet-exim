define exim::configure ($php_ini_location = "/etc/php5/apache2/php.ini") {

  Class[ "exim::install" ] -> Exim::Configure[$title]

  file { "/etc/exim4/update-exim4.conf.conf":
    ensure	  => file,
    source	  => "puppet:///modules/exim/exim.conf",
    group	    => root,
    owner	    => root,
    notify    => Exec["restart-exim4"],
  } ->

  exec { "add-exim-to-php-ini":
    command => "sudo sed -i -e 's#;sendmail_path =#sendmail_path = \"/usr/sbin/sendmail -t\"#g' $php_ini_location",
    notify  => Exec["restart-exim4"],
    path    => [ "/usr/bin", "/bin" ],
  } ->

  exec { "restart-exim4":
    command     => "sudo /etc/init.d/exim4 restart",
    subscribe   => [
      File["/etc/exim4/update-exim4.conf.conf"],
      Exec["add-exim-to-php-ini"]
    ],
    refreshonly => true,
    path        => [ "/usr/bin", "/bin" ],
  }

}