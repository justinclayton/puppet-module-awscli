[![Build Status](https://travis-ci.org/justinclayton/puppet-module-awscli.png?branch=master)](https://travis-ci.org/justinclayton/puppet-module-awscli)

Description
-------
This module installs awscli via pip. Validated to run on CentOS 6.x, but might run elsewhere.

Installation
------
If you're using librarian-puppet, add a line to your `Puppetfile`:

```
mod 'justinclayton/awscli', '1.x'
```

Usage
------
To use this module in your manifests, simply add:

```
include awscli
```

If for some reason you don't want the module to use the public EPEL repo to retrieve python-pip (e.g., you are mirroring EPEL internally), use this syntax instead:

```
class { 'awscli':
  enable_epel => false,
}
```
