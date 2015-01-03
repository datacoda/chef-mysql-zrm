require 'spec_helper'

# Ensure mysql ZRM exists

describe package('mysql-zrm') do
  it { should be_installed }
end
