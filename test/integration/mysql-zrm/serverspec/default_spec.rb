require 'spec_helper'

# Ensure mysql ZRM exists

describe package('mysql-zrm') do
  it { should be_installed }
end

describe file('/etc/mysql-zrm/test_backup/mysql-zrm.conf') do
  its(:content) { should match(/databases=employees/) }
  its(:content) { should match(/all-databases=0/) }
  its(:content) { should match(/backup-level=0/) }
  its(:content) { should match(/compress=0/) }
  its(:content) { should match(/retention-policy=10D/) }
  its(:content) { should match %r{destination=/var/lib/mysql-zrm} }
end

describe file('/etc/mysql-zrm/all_backup/mysql-zrm.conf') do
  its(:content) { should match(/all-databases=1/) }
  its(:content) { should match(/backup-level=0/) }
  its(:content) { should match(/compress=1/) }
  its(:content) { should match(/retention-policy=30D/) }
  its(:content) { should match %r{destination=/var/lib/mysql-zrm} }
end
