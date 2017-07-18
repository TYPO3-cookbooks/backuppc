name             "backuppc"
maintainer       "TYPO3 Association"
maintainer_email "steffen.gebert@typo3.org"
license          "Apache 2.0"
description      "BackupPC Server and Client"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))

version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue '0.0.1'

depends          "ssl_certificates"

depends          "apache2", "~> 4.0"
depends          "htpasswd"
depends          "sudo"
depends          "user"
depends          "apt"
