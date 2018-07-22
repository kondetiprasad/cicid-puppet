class example::create_user {
	group { 'sandeep':
  		  ensure => 'present',
  		  gid    => '1012',
     	}
user { 'sandeep':
 	ensure           => 'present',
      	home             => '/home/sandeep',
      	comment           => 'Sandeep Rawat',
      	groups            => 'sandeep',
      	shell            => '/bin/bash',
      	uid              => '14000',
    }
}
