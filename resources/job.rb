#
# Cookbook Name:: mysql-zrm
# Resource:: mysql_zrm_job
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
attribute :set,       :kind_of => String
attribute :level,     :kind_of => Symbol, :equal_to => [:full, :incremental], :default => :full
attribute :interval,  :kind_of => Symbol, :equal_to => [:daily, :weekly, :monthly], :default => :weekly
attribute :minute,    :kind_of => [Integer, String], :default => 0
attribute :hour,      :kind_of => [Integer, String], :default => 0
attribute :day,       :kind_of => [Integer, String], :default => "*"
attribute :weekday,   :kind_of => [Integer, String], :default => "*"

def initialize(*args)
  super
  @action = :create
end

