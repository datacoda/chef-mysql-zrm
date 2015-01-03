name 'mysql-zrm'
maintainer 'Nephila Graphic'
maintainer_email 'ted@nephilagraphic.com'
license 'Apache 2.0'
description 'Installs/Configures Zmanda Recovery Manager for MySQL'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.2'

supports 'ubuntu', '>= 12.04'
supports 'debian', '>= 7.0'

recommends 'mysql'
