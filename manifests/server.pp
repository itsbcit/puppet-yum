class yum::server(
    $basedir = '/var/www/yum',
    $repos   = [],
) inherits yum {
    file { $basedir:
        ensure => directory,
        owner  => $owner,
        group  => $group,
        mode   => $mode
    }

    yum::repo{$repos: }
}
