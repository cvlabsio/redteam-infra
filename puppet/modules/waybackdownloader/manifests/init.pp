# Copyright (c) 2023, Oracle and/or its affiliates.

class waybackdownloader {
    package { 'wayback_machine_downloader':
        ensure   => 'installed',
        provider => 'gem',
    }
}
