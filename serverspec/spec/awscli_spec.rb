require 'serverspec'
require 'pathname'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe file('/usr/bin/aws') do
  it { should be_file     }
  it { should be_mode 755 }
end

describe command('aws') do
  it { should return_exit_status 2 }
end
