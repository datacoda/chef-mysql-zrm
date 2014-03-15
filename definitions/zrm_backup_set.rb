#
# Cookbook Name:: mysql-zrm
# Definitions:: zrm_backup_set
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

define :zrm_backup_set,
       :databases => :all,
       :backup_level => :full,
       :host => nil,
       :port => 3306,
       :user => nil,
       :password => nil,
       :default_character_set => 'utf8',
       :single_transaction => true,
       :destination => nil,
       :compress => false,
       :encrypt => false,
       :retention => '10D',
       :extra_mysqldump_options => [],
       :replication_slave => false,
       :template => 'backup_set.conf.erb',
       :cookbook => 'mysql-zrm' do

  directory "#{node['mysql-zrm']['dir']}/#{params[:name]}" do
    action :create
  end

  # default destination path
  destination = params[:destination] ||= "/var/lib/mysql-zrm"
  backup_level = "0"
  case params[:backup_level]
    when "full"
      backup_level = "0"
    when "incremental"
      backup_level = "1"
    else
      Chef::Log.fatal("Invalid backup level")
  end

  databases = []
  mysqldump_options = [ params[:extra_mysqldump_options] ]
  if params[:databases] == :all
    mysqldump_options << "--events"
    all_databases = "1"
  else
    databases << params[:databases]
    all_databases = "0"
  end

  template "#{node['mysql-zrm']['dir']}/#{params[:name]}/mysql-zrm.conf" do
    cookbook  params[:cookbook]
    source    params[:template]
    owner     "root"
    group     "root"
    mode      0600
    variables(
        :host => params[:host],
        :port => params[:port],
        :user => params[:user],
        :password => params[:password],
        :default_character_set => params[:default_character_set],
        :single_transaction => params[:single_transaction] ? "1" : "0",
        :backup_level => backup_level,
        :databases => databases,
        :all_databases => all_databases,
        :destination => destination,
        :extra_mysqldump_options => mysqldump_options,
        :replication => params[:replication_slave] ? "1" : "0",
        :compress => params[:compress] ? "1" : "0",
        :encrypt => params[:encrypt] ? "1" : "0",
        :retention => params[:retention]
    )
  end
end
