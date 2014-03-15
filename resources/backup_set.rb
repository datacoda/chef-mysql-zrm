#
# Cookbook Name:: mysql-zrm
# Resource:: backup_set
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

actions :create, :delete


attribute :name,      :kind_of => String, :name_attribute => true
attribute :comment,   :kind_of => [String, NilClass]
attribute :databases, :kind_of => Array, :default => []
attribute :level,     :kind_of => Symbol, :equal_to => [:full, :incremental], :default => :full

attribute :host,      :kind_of => [String, NilClass]
attribute :user,      :kind_of => [String, NilClass]
attribute :password,  :kind_of => [String, NilClass]
attribute :port,      :kind_of => [String, Integer], :default => 3306

attribute :default_character_set, :kind_of => String, :default => 'utf8'
attribute :single_transaction,    :kind_of => [TrueClass, FalseClass], :default => true
attribute :destination,           :kind_of => String, :default => '/var/lib/mysql-zrm'

attribute :compress,  :kind_of => [TrueClass, FalseClass], :default => false
attribute :encrypt,   :kind_of => [TrueClass, FalseClass], :default => false
attribute :slave,     :kind_of => [TrueClass, FalseClass], :default => false
attribute :retention, :kind_of => String, :default => '10D'

attribute :extra_mysqldump_options, :kind_of => Array, :default => []

attribute :template,  :kind_of => String, :default => 'backup_set.conf.erb'
attribute :cookbook,  :kind_of => String, :default => 'mysql-zrm'

def initialize(*args)
  super
  @action = :create
end

