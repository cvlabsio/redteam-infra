# Copyright (c) 2022, Oracle and/or its affiliates.

class nfsserver::packages {
  $packages = ['nfs-kernel-server']

  package { $packages: ensure => "installed" }

}
