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
	class { 'jenkins':
	  install_java => false,
	  version => '1.651.1-1.1',
	  lts    => true,
	  configure_firewall => false,
	  executors => 3,
	  plugin_hash => {
	    'workflow-aggregator'   => {}, 
	    'build-pipeline-plugin' => {},
	    'cobertura' => {},
	    'github' => {}, 			
	    'git' => {},		
	    'junit' => {},
	    'cucumber-reports' => {},
	    'parameterized-trigger' => {},
	    'conditional-buildstep' => {},
	    'htmlpublisher' => {},
	    'promoted-builds' => {},	
	    'maven-plugin' => { manage_config => true,
	                        config_filename => 'hudson.tasks.Maven.xml',
	                        config_content => template('jenkins/config/plugin/hudson.tasks.Maven.xml.erb')},        
	    'sonar' => { 	manage_config => true,
	 				     		 	config_filename => 'hudson.plugins.sonar.SonarGlobalConfiguration.xml',
					     			config_content => template('jenkins/config/plugin/hudson.plugins.sonar.SonarGlobalConfiguration.xml.erb') },
	    'xvfb' => { manage_config => true,
	                config_filename => 'org.jenkinsci.plugins.xvfb.Xvfb.xml',
	                config_content => template('jenkins/config/plugin/org.jenkinsci.plugins.xvfb.Xvfb.xml.erb')}
	  },
	  job_hash => {
	    'META'		=> { config => template("jenkins/config/jobs/META.xml.erb") },
	  }
	 }->
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
}

node "dev-logserver-az-a.demo.training.com" {
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
