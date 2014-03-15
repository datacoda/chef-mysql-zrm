#
# Cookbook Name:: mysql-zrm
# Provider:: job
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
  cmd = cron_command

  c = cron new_resource.name do
    minute    new_resource.minute
    hour      new_resource.hour
    weekday   new_resource.weekday
    day       new_resource.day
    command   cmd
    action    :delete
  end
end


action :create do
  cmd = cron_command

  cron "purge" do
    hour      4
    minute    0
    command   "/usr/bin/mysql-zrm --action purge"
    action    :create
  end

  c = cron new_resource.name do
    minute    new_resource.minute
    hour      new_resource.hour
    weekday   new_resource.weekday
    day       new_resource.day
    command   cmd
    action    :create
  end

  new_resource.updated_by_last_action(c.updated_by_last_action?)
end


private

def cron_command
  cmd_options = [ "--action backup" ]
  cmd_options << "--backup-set #{new_resource.backup_set}"
  case new_resource.level
    when :full
      cmd_options << "--backup-level 0"
    when :incremental
      cmd_options << "--backup-level 1"
  end
  cmd_options << "--interval #{new_resource.interval}"

  return "/usr/bin/zrm-pre-scheduler #{cmd_options.flatten.join ' '}"
end
