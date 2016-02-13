#<> default user/password for web interface: backuppc
default['backuppc']['server']['users'] = {
  "backuppc"  => "$apr1$buOuPFmQ$iFBwTcVvrX5Pgx7FLHdlp1"
}
#<> Search query to find all nodes to backup
default['backuppc']['server']['hosts_search_query'] = "chef_environment:production NOT roles:backuppc-server"