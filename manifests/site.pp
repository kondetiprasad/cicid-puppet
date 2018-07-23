	class{ '::java': 
		distribution => "jdk",
	}->
	class { 'jenkins': }
	class { "ssh::jenkins": }
	class { 'git': }
	class {'timezone':}
	class { 'ntp':}
	class { 'zabbix::agent': }
	class { 'pip': }
	class { 'beaver': }
	class { 'beaver::input::files': }
	class { 'beaver::output::redis_out': }
	class { 'mysql::server': }
	class { 'mysql::dbs': }
	class { 'sonarqube': }
