require 'serverspec'

include Serverspec::Helper::Exec

# Ensure mysql ZRM exists
describe command('which mysql-zrm') do
  it { should return_exit_status 0 }
end