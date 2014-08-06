class yum::server(
    $basedir = '/var/www/yum',
    $repos   = [],
    $owner   = 'root',
    $group   = 'root',
    $mode    = '0755'
) inherits yum {

    ensure_packages('createrepo')

    file { $basedir:
        ensure => directory,
        owner  => $owner,
        group  => $group,
        mode   => $mode
    }

    yum::repo{$repos:
        basedir => $basedir,
        owner   => $owner,
        group   => $group,
        mode    => $mode
    }
}
