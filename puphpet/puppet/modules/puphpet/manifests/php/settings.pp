class puphpet::php::settings (
  $version_string
){

  if $version_string == '7.0' or $version_string == '70' {
    $version = '70'
  } else {
    $version = $version_string
  }

  $enable_modules = true
  $enable_pear    = true
  $enable_pecl    = true
  $enable_xdebug  = true

  if $version == '70' {
    $prefix = $::osfamily ? {
      'Debian' => $::operatingsystem ? {
        'ubuntu' => 'php7.0-',
        'debian' => 'php7-'
      },
      'Redhat' => 'php-'
    }

    $package_devel = 'php-devel'

    $base_ini = $::osfamily ? {
      'debian' => '/etc/php/7.0/php.ini',
      'redhat' => '/etc/php.ini',
    }

    $fpm_ini = $::osfamily ? {
      'debian' => '/etc/php7/fpm/php.ini',
      'redhat' => '/etc/php.ini',
    }

    $pid_file = $::osfamily ? {
      'debian' => '/run/php-fpm.pid',
      'redhat' => '/var/run/php-fpm.pid',
    }
  } else {
    $prefix = $::osfamily ? {
      'debian' => 'php5-',
      'redhat' => 'php-',
    }

    $package_devel = $php::params::package_devel

    $base_ini = $::osfamily ? {
      'debian' => '/etc/php5/php.ini',
      'redhat' => '/etc/php.ini',
    }

    $fpm_ini = $::osfamily ? {
      'debian' => '/etc/php5/fpm/php.ini',
      'redhat' => '/etc/php.ini',
    }

    $pid_file = $::osfamily ? {
      'debian' => '/run/php-fpm.pid',
      'redhat' => '/var/run/php-fpm/php-fpm.pid',
    }
  }

  $cli_package = "${prefix}cli"
  $fpm_package = "${prefix}fpm"
  $service     = "${prefix}fpm"

  Package[$fpm_package]
  -> Puphpet::Php::Module <| |>

  Package[$fpm_package]
  -> Puphpet::Php::Pear <| |>

  Package[$fpm_package]
  -> Puphpet::Php::Pecl <| |>

  Package[$fpm_package]
  -> Puphpet::Php::Ini <| |>

  Package[$fpm_package]
  -> Puphpet::Php::Fpm::Ini <| |>

  Package[$fpm_package]
  -> Puphpet::Php::Fpm::Pool_ini <| |>

}
