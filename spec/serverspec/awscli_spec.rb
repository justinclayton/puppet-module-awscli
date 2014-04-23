require 'serverspec'
require 'pathname'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe file('/usr/local/bin/aws') do
  it { should be_file     }
  it { should be_mode 755 }
end