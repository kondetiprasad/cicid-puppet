class example::template(
  $name = '',
  $address= ''
) {
	file {"/root/template/aaddress":
  		ensure  => file,
  		content => template('example/address.erb'),
        	owner  => "root",
        	group  => "root",
        	mode  => "600",
		require => File['/root/template/']
    	}
    	file {"/root/template/":
        	ensure => directory,
       	 	owner => "root",
        	group => "root",
        	mode  => "700"
    	}

}
