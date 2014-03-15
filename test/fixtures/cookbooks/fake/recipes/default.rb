
include_recipe 'mysql-zrm::default'

zrm_backup_set "test_backup" do
  databases [ "employees" ]
end

zrm_backup_set "all_backup" do
  databases :all
end


mysql_zrm_job "weekly" do
  set         "test_backup"
  level       :full
  interval    :weekly
  hour        "01"
  minute      "00"
  weekday     "4"
  #day        31
end