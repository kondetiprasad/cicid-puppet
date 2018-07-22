class example::create_file {
    file {"/root/puppet/file.conf":
        source => "puppet:///modules/example/file.conf",
        owner  => "root",
        group  => "root",
        mode  => "600",
        require => File["/root/puppet/"]
    }
    file {"/root/puppet/":
        ensure => directory,
        owner => "root",
        group => "root",
        mode  => "700"
    }
}

