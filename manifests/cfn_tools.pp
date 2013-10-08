  $tmp_dir = "/tmp"
  $vagrant_dir = "/home/vagrant"
  $cfn_tools_dir = ".awstools"
  $cfn_version = "1.0.12"
  $ec2_tools_dir = ".ec2tools"
  $ec2_version = "1.6.10.0"

  exec { "download_cfn_tools":
    command   => "curl -k -L -o ${tmp_dir}/AWSCloudFormation-cli.zip https://s3.amazonaws.com/cloudformation-cli/AWSCloudFormation-cli.zip",
    creates   => "${tmp_dir}/AWSCloudFormation-cli.zip",
    logoutput => true,
    require   => [Package["curl"]],                                         
    timeout   => 600
  }

  archive::extract { "AWSCloudFormation-cli":
    ensure      => present,
    target      => "${vagrant_dir}/${cfn_tools_dir}",
    src_target  => $tmp_dir,
    extension   => "zip",
    require     => [Package["unzip"], Exec["download_cfn_tools"]]
  }

  exec { "cfn-link":
    command => "ln -s ${vagrant_dir}/${cfn_tools_dir}/AWSCloudFormation-${cfn_version} ${vagrant_dir}/${cfn_tools_dir}/cfn",
    require => [Archive::Extract["AWSCloudFormation-cli"]]
  }

  file { "${vagrant_dir}/${cfn_tools_dir}":
    recurse => true,
    owner   => "vagrant",
    group   => "vagrant",
    mode    => 755, 
    require => [Exec["cfn-link"]]
  }

  exec { "download_ec2_tools":
    command   => "curl -k -L -o ${tmp_dir}/ec2-api-tools.zip http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip",
    creates   => "${tmp_dir}/ec2-api-tools.zip",
    logoutput => true,
    require   => [Package["curl"]],  
    timeout   => 600
  }

  archive::extract { "ec2-api-tools":
    ensure      => present,
    target      => "${vagrant_dir}/${ec2_tools_dir}",
    src_target  => $tmp_dir,
    extension   => "zip",
    require     => [Package["unzip"], Exec["download_ec2_tools"]]
  }

  exec { "ec2-link":
    command => "ln -s ${vagrant_dir}/${ec2_tools_dir}/ec2-api-tools-${ec2_version} ${vagrant_dir}/${ec2_tools_dir}/ec2",
    require => [Archive::Extract["ec2-api-tools"]]
  }

  file { "${vagrant_dir}/${ec2_tools_dir}":
    recurse => true,
    owner   => "vagrant",
    group   => "vagrant",
    mode    => 755, 
    require => [Exec["ec2-link"]]
  }
}
