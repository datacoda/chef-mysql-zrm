#
# Cookbook Name:: mysql-zrm
# Provider:: backup_set
#
# Copyright (C) 2014 Nephila Graphic
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


action :delete do
  r = file "#{node['mysql-zrm']['dir']}/#{new_resource.name}/mysql-zrm.conf" do
    action :delete
  end
  new_resource.updated_by_last_action(r.updated_by_last_action?)
end


action :create do
  directory "#{node['mysql-zrm']['dir']}/#{new_resource.name}" do
    action :create
  end

  backup_level = '0'
  case new_resource.level
  when 'full'
    backup_level = '0'
  when 'incremental'
    backup_level = '1'
  else
    Chef::Log.fatal('Invalid backup level')
  end

  all_databases = '0'
  mysqldump_options = [new_resource.extra_mysqldump_options]
  if new_resource.databases.empty?
    all_databases = '1'
    mysqldump_options << '--events'
  end

  t = template "#{node['mysql-zrm']['dir']}/#{new_resource.name}/mysql-zrm.conf" do
    cookbook new_resource.cookbook
    source new_resource.template
    owner 'root'
    group 'root'
    mode 0600
    variables(
        comment: new_resource.comment ? new_resource.comment : new_resource.name,
        host: new_resource.host,
        port: new_resource.port,
        user: new_resource.user,
        password: new_resource.password,
        default_character_set: new_resource.default_character_set,
        single_transaction: new_resource.single_transaction ? '1' : '0',
        backup_level: backup_level,
        databases: new_resource.databases,
        all_databases: all_databases,
        destination: new_resource.destination,
        extra_mysqldump_options: mysqldump_options,
        replication: new_resource.slave ? '1' : '0',
        compress: new_resource.compress ? '1' : '0',
        encrypt: new_resource.encrypt ? '1' : '0',
        retention: new_resource.retention
    )
    action :create
  end
  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

