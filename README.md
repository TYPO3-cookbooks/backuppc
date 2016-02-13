# Description

Chef recipe for BackupPC

# Attributes

* `node['backuppc']['user']` -  Defaults to `backuppc`.
* `node['backuppc']['server']['users']` -  Defaults to `{ ... }`.

# Recipes

* backuppc::default
* backuppc::server

# Monitoring

* Zabbix monitoring is included
* The [original zabbix-backuppc.pl](https://github.com/szimszon/backuppc_monitor_zabbix/blob/4edf191532b4eb79df7a55f01278c38f769fbf61/zabbix-backuppc.pl) was modified to specify full paths to config file and `zabbix_sender`.

# License and Maintainer

Maintainer:: Steffen Gebert / TYPO3 Association (<steffen.gebert@typo3.org>)

License:: Apache 2.0
