# Install and configuring exim
include exim::install

exec { "add-php7-repository":
    command => "sudo LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php",
    path    => [ "/bin", "/usr/bin", "/usr/local/bin" ],
} ->

exec { "apt-key-repository":
    command     => "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C",
    path        => [ "/bin", "/usr/bin", "/usr/local/bin" ],
}

exec { "apt-update-and-install":
    command     => "sudo apt-get update && sudo apt-get install --yes php7.0",
    require     => Exec[ "apt-key-repository" ],
    path        => [ "/bin", "/usr/bin", "/usr/local/bin" ],
} ->

exim::configure { "configure-exim":
    php_ini_location => "/etc/php/7.0/apache2/php.ini"
}
