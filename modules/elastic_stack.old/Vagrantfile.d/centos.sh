# Install and configure Puppet and Puppetserver.

sudo rpm -Uvh https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm

dpkg -i puppet5-release-xenial.deb
yum install -y apt-transport-https
yum install -y puppet-agent puppetserver

# REF: https://tickets.puppetlabs.com/browse/SERVER-528
service puppet stop
service puppetserver stop
rm -rf /etc/puppetlabs/puppet/ssl/private_keys/*
rm -rf /etc/puppetlabs/puppet/ssl/certs/*
echo 'autosign = true' >> /etc/puppetlabs/puppet/puppet.conf
service puppetserver start

# Puppet agent looks for the server called "puppet" by default.
# In this case, we want that to be us (the loopback address).
echo '127.0.0.1 localhost puppet vagrant' > /etc/hosts

# Install puppet-elastic-stack dependencies.
for module in puppetlabs-apt puppet-yum darin-zypprepo; do
  /opt/puppetlabs/bin/puppet module install \
  --target-dir=/etc/puppetlabs/code/environments/production/modules \
  $module
done
