include_recipe 'apt::default'
include_recipe 'postfix::default'

mysql_service 'default' do
  port '3306'
  version '5.5'
  initial_root_password node['mysql']['server_root_password']
  action [:create, :start]
end

# Some mail package required otherwise zrm complains

package 'mailx' do
  package_name 'heirloom-mailx'
  action :install
end

include_recipe 'mysql-zrm::solo-install'

mysql_zrm_backup_set 'test_backup' do
  databases ['employees']
end

mysql_zrm_backup_set 'all_backup' do
end

mysql_zrm_job 'weekly' do
  backup_set 'test_backup'
  level :full
  interval :weekly
  hour '01'
  minute '00'
  weekday '4'
end
