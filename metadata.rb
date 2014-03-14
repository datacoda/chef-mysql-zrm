name             'mysql-zrm'
maintainer       'Nephila Graphic'
maintainer_email 'ted@nephilagraphic.com'
license          'Apache 2.0'
description      'Installs/Configures Zmanda Recovery Manager for MySQL'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

%w{ ubuntu debian }.each do |os|
  supports os
end

recommends 'postfix'
recommends 'mailx'
recommends 'mysql'
