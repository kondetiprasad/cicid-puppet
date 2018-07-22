class example::install_package {

	package { 'git':
		ensure => present
	}
        package { 'nginx':
                ensure => present
        }
        package { 'ntp':
                ensure => present
        }
        package { 'vim':
                ensure => present
        }
}
