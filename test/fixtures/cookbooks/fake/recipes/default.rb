
include_recipe 'mysql-zrm::default'

mysql_zrm_backup_set "test_backup" do
  databases [ "employees" ]
end

mysql_zrm_backup_set "all_backup" do
end


mysql_zrm_job "weekly" do
  backup_set  "test_backup"
  level       :full
  interval    :weekly
  hour        "01"
  minute      "00"
  weekday     "4"
end
