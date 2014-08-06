define yum::repo(
    $basedir,
    $owner,
    $group,
    $mode,
) {
    file { "${basedir}/$name":
        ensure  => directory,
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        require => File[$basedir]
    }

    exec { "Create repo ${basedir}/${name}":
        command => "/usr/bin/createrepo .",
        creates => "${basedir}/${name}/repodata",
        cwd     => "${basedir}/${name}",
        group   => $group,
        user    => $owner,
        require => [
            File["${basedir}/${name}"],
            Package["createrepo"],
        ],
    }
}
