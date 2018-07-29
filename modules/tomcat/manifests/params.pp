# == Class: tomcat::params
#
class tomcat::params {
  case $::osfamily {
    'RedHat' : {
      case $::operatingsystem {
        'Fedora' : {
          case $::operatingsystemmajrelease {
            '25'    : {
              $version = '1:8.0.39'
              $package_name = 'tomcat'
            }
            '24'    : {
              $version = '1:8.0.39'
              $package_name = 'tomcat'
            }
            '23'    : {
              $version = '1:8.0.39'
              $package_name = 'tomcat'
            }
            default : {
              fail("Unsupported OS version ${::operatingsystemmajrelease}")
            }
          }
          $systemd = true
        }
        'Amazon' : {
          # https://alas.aws.amazon.com
          $version = '8.0.38'
          $package_name = 'tomcat8'
          # $version = '7.0.72-1.21.amzn1' # ALAS-2016-764
          # $package_name = 'tomcat7'
          # $version = '6.0.47-1.7.amzn1'  # ALAS-2016-764
          # $package_name = 'tomcat6'
          $systemd = false
        }
        default  : {
          case $::operatingsystemmajrelease {
            '7'     : {
              $version = '7.0.69'
              $package_name = 'tomcat'
              $systemd = true
            }
            '6'     : {
              $version = '6.0.24'
              $package_name = 'tomcat6'
              # = epel repo =
              # https://dl.fedoraproject.org/pub/epel/6/x86_64/
              # $version = '7.0.72-1.el6'
              # $package_name = 'tomcat'
              # = jpackage6 repo =
              # http://mirrors.dotsrc.org/jpackage/6.0/generic/free/repoview/letter_t.group.html
              # $version = '5.5.35-1.jpp6'
              # $package_name = 'tomcat5'
              # $version = '6.0.33-2.jpp6'
              # $package_name = 'tomcat6'
              # $version = '7.0.54-2.jpp6'
              # $package_name = 'tomcat7'
              $systemd = false
            }
            '5'     : {
              $version = '5.5.23'
              $package_name = 'tomcat5'
              # = jpackage5 repo =
              # http://mirrors.dotsrc.org/jpackage/5.0-updates/generic/free/repoview/letter_t.group.html
              # $version = '5.5.27-7.jpp5'
              # $package_name = 'tomcat5'
              # $version = '6.0.36-1.jpp5'
              # $package_name = 'tomcat6'
              $systemd = false
            }
            default : {
              fail("Unsupported OS version ${::operatingsystemmajrelease}")
            }
          }
        }
      }
      $tomcat_native_package_name = 'tomcat-native'
      $log4j_package_name = 'log4j'
    }
    'Suse'   : {
      case $::operatingsystem {
        'OpenSuSE'           : {
          case $::operatingsystemrelease {
            '42.2'  : {
              # http://download.opensuse.org/distribution/leap/42.2/repo/oss/suse/noarch/
              # http://download.opensuse.org/update/leap/42.2/oss/noarch/
              $version = '8.0.36'
              $package_name = 'tomcat'
              # = JAVA repo =
              # http://download.opensuse.org/repositories/Java:/packages/openSUSE_Leap_42.2/noarch/
              # $version = '8.0.36-117.13'
              # $package_name = 'tomcat'
            }
            '42.1'  : {
              # http://download.opensuse.org/distribution/leap/42.1/repo/oss/suse/noarch/
              # http://download.opensuse.org/update/leap/42.1/oss/noarch/
              $version = '8.0.32'
              $package_name = 'tomcat'
              # = JAVA repo =
              # http://download.opensuse.org/repositories/Java:/packages/openSUSE_Leap_42.1/noarch/
              # $version = '8.0.36-117.11'
              # $package_name = 'tomcat'
            }
            '13.2'  : {
              # http://download.opensuse.org/distribution/13.2/repo/oss/suse/noarch/
              $version = '7.0.55'
              $package_name = 'tomcat'
              # = JAVA repo =
              # http://download.opensuse.org/repositories/Java:/packages/openSUSE_13.2/noarch/
              # $version = '8.0.36-115.1'
              # $package_name = 'tomcat'
            }
            default : {
              fail("Unsupported OS version ${::operatingsystemrelease}")
            }
          }
          $systemd = true
        }
        /^(SLES|SLED|SuSE)$/ : {
          # https://download.suse.com/patch/finder
          case $::operatingsystemrelease {
            '12.2'  : {
              $version = '8.0.36'
              $package_name = 'tomcat'
              $systemd = true
            }
            '12.1'  : {
              $version = '8.0.32'
              $package_name = 'tomcat'
              # = JAVA repo =
              # http://download.opensuse.org/repositories/Java:/packages/SLE_12_SP1/noarch/
              # $version = ''
              $systemd = true
            }
            '12.0'  : {
              $version = '7.0.68'
              $package_name = 'tomcat'
              $systemd = true
            }
            '11.4'  : {
              $version = '6.0.45'
              $package_name = 'tomcat6'
              $systemd = false
            }
            '11.3'  : {
              $version = '6.0.41'
              $package_name = 'tomcat6'
              $systemd = false
            }
            default : {
              fail("Unsupported OS version ${::operatingsystemrelease}")
            }
          }
        }
        default              : {
          fail("Unsupported OS ${::operatingsystem}")
        }
      }
      $tomcat_native_package_name = 'libtcnative-1-0'
      $log4j_package_name = 'log4j'
    }
    'Debian' : {
      case $::operatingsystem {
        'Debian' : {
          case $::operatingsystemmajrelease {
            # jessie
            '8'     : {
              $version = '8.0.14-1+deb8u5'
              $package_name = 'tomcat8'
              # $version = '7.0.56-3+deb8u6'
              # $package_name = 'tomcat7'
            }
            # wheezy
            '7'     : {
              $version = '7.0.28-4+deb7u8'
              $package_name = 'tomcat7'
              # $version = '6.0.45+dfsg-1~deb7u5'
              # $package_name = 'tomcat6'
            }
            default : {
              fail("Unsupported OS version ${::operatingsystemmajrelease}")
            }
          }
        }
        'Ubuntu' : {
          case $::operatingsystemrelease {
            # yakkety
            '16.10' : {
              $version = '8.0.37-1'
              $package_name = 'tomcat8'
              # $version = '7.0.72-1'
              # $package_name = 'tomcat7'
            }
            # xenial
            '16.04' : {
              $version = '8.0.32-1ubuntu1.2'
              $package_name = 'tomcat8'
              # $version = '7.0.68-1ubuntu0.1'
              # $package_name = 'tomcat7'
            }
            # wily
            '15.10' : {
              $version = '8.0.26-1'
              $package_name = 'tomcat8'
              # $version = '7.0.64-1ubuntu0.3'
              # $package_name = 'tomcat7'
            }
            # vivid
            '15.04' : {
              $version = '8.0.14-1+deb8u1build0.15.04.1'
              $package_name = 'tomcat8'
              # $version = '7.0.56-2ubuntu0.1'
              # $package_name = 'tomcat7'
            }
            # utopic
            '14.10' : {
              $version = '8.0.9-1'
              $package_name = 'tomcat8'
              # $version = '7.0.55-1ubuntu0.2'
              # $package_name = 'tomcat7'
              # $version = '6.0.41-1'
              # $package_name = 'tomcat6'
            }
            # trusty
            '14.04' : {
              $version = '7.0.52-1ubuntu0.7'
              $package_name = 'tomcat7'
              # $version = '6.0.39-1'
              # $package_name = 'tomcat6'
            }
            # saucy
            '13.10' : {
              $version = '7.0.42-1ubuntu0.1'
              $package_name = 'tomcat7'
              # $version = '6.0.37-1'
              # $package_name = 'tomcat6'
            }
            # raring
            '13.04' : {
              $version = '7.0.35-1~exp2ubuntu1.1'
              $package_name = 'tomcat7'
              # $version = '6.0.35-6'
              # $package_name = 'tomcat6'
            }
            # quantal
            '12.10' : {
              $version = '7.0.30-0ubuntu1.3'
              $package_name = 'tomcat7'
              # $version = '6.0.35-5ubuntu0.1'
              # $package_name = 'tomcat6'
            }
            # precise
            '12.04' : {
              $version = '7.0.26-1ubuntu1.2'
              $package_name = 'tomcat7'
              # $version = '6.0.35-1ubuntu3.8'
              # $package_name = 'tomcat6'
            }
            default : {
              fail("Unsupported OS version ${::operatingsystemrelease}")
            }
          }
        }
        default  : {
          fail("Unsupported OS ${::operatingsystem}")
        }
      }
      $tomcat_native_package_name = 'libtcnative-1'
      $log4j_package_name = 'liblog4j1.2-java'
      $systemd = false
    }
    default  : {
      fail("Unsupported OS family ${::osfamily}")
    }
  }
}
