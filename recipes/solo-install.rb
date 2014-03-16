#
# Cookbook Name:: mysql-zrm
# Recipe:: solo-install
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

pkg_filepath = "#{Chef::Config['file_cache_path'] || '/tmp'}/#{File.basename(node['mysql-zrm']['package']['all'])}"


# Download and build MySQL ZRM
remote_file pkg_filepath do
  source node['mysql-zrm']['package']['all']
  action :create_if_missing
  not_if 'which mysql-zrm'
end

# Install package dependencies for mysql-zrm
package "libxml-parser-perl" do
  action :install
end

dpkg_package pkg_filepath do
  action :install
  not_if 'which mysql-zrm'
end
