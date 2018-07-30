node "proxy-dev-az-a.demo.training.com" {
hiera_include('classes')
}

node "proxy-dev-az-b.demo.training.com" {
hiera_include('classes')
}

node "app-dev-az-a.demo.training.com" {
hiera_include('classes')
}

node "app-dev-az-b.demo.training.com" {
hiera_include('classes')
}

node "mysql-dev-az-a.demo.training.com" {
hiera_include('classes')
}

node "zabbix-dev-az-b.demo.training.com" {
hiera_include('classes')
}

node "jenkins-dev-az-a.demo.training.com" {
	class{ '::java': 
		distribution => "jdk",
	}->
	class { 'jenkins': }->
	class { "ssh::jenkins": }
	class { 'git': }
	class {'timezone':}
	class { 'ntp':}
	class { 'zabbix::agent': }
	class { 'mysql::server': }
	class { 'mysql::dbs': }
	class { 'sonarqube': }
        class { 'nexus': }
}

node "logserver-dev-az-a.demo.training.com" {
	class {'timezone':}
	class { 'ntp':}
	class { 'zabbix::agent': }
	class{ '::java': 
		distribution => "jre",
	}->
	class { 'redis': 
		listen => "0.0.0.0"
	}->
	class { 'elasticsearch':
	  package_url => 'https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.1.1/elasticsearch-2.1.1.rpm',
	  notify => Exec["elasticsearch service start"],
	}->
	class { 'logstash':
	  manage_repo  => true,
	  repo_version => '2.1',
	}->
	class { 'kibana': 
		version => '4.3.1',
		bind => '0.0.0.0'
	}->
	class { 'pip': }->
	class { 'beaver': 
		status => enabled,
	}
	beaver::input::file{ "syslog":
		file => '/var/log/messages',
		type => 'syslog'
	}
	beaver::output::redis{ 'redisout':
		host =>'dev.logserver.az.a.demo.training.com',
		port => '6379',
	}

	logstash::configfile { 'input_redis':
	  template => 'logstash/input_redis.erb',
	  order    => 10,
	}
	logstash::configfile { 'output_es':
	  template => 'logstash/output_es_cluster.erb',
	  order   => 30,
	}
	exec { "elasticsearch service start":
	    command => "/bin/bash -c \"service elasticsearch restart\"",
	    path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin/'],
	}	
}
