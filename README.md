mysql-zrm cookbook
==================

Installs and configures Zmanda Recovery Manager for MySQL.

Requirements
------------

A mailx compatible package, previously installed.

Usage
-----
TBD

Attributes
----------
TBD


Recipes
-------
This cookbook does only one thing right now.

- `default.rb` - Provides the LWRP.
- `solo-install.rb` - Installs ZRM.


Resources
---------
This cookbook contains two LWRP to define backup sets and add jobs.

### mysql_zrm_backup_set
Creates a backup set configuration file.  LWRP usage is as follows

```ruby
mysql_zrm_backup_set "test_backup" do
  databases [ "employees" ]
end
```

By default, it will attempt to use the /root/.my.cnf to log into MySQL to
perform the backup.  Be sure to add `user` and `password` in the configuration file.

```ini
[mysqladmin]
user=root
password=secret
```


### mysql_zrm_job
Creates a cron job using the specified backup set

```ruby
mysql_zrm_job "weekly" do
  backup_set  "test_backup"
  level       :full
  interval    :weekly
  hour        "01"
  minute      "00"
  weekday     "4"
end
```

Incrementals can be done as follows

```ruby
mysql_zrm_job "daily" do
  backup_set  "test_backup"
  level       :incremental
  interval    :daily
  hour        "02"
  minute      "00"
end
```



How to Contribute
-----------------
Depending on project needs, we might expand this cookbook to better support remote ZRM backups.  Please feel
free to fork and submit pull requests.


License & Authors
-----------------
- Author:: Ted Chen (<ted@nephilagraphic.com>)

```text
Copyright 2014, Nephila Graphic

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```