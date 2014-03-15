
include_recipe 'mysql-zrm::default'

zrm_backup_set "test_backup" do
  databases ["test" ]
end

zrm_backup_set "all_backup" do
  databases :all
end