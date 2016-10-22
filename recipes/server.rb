#
# Cookbook Name:: backuppc
# Recipe:: server
#
# Copyright 2012, Steffen Gebert / TYPO3 Association
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# using the located database makes no sense and costs a lot of CPU
package "mlocate" do
  action :purge
end

package "backuppc"
package "libfile-rsyncp-perl"

service "backuppc" do
  supports :restart => true, :reload => true
end

template "/etc/backuppc/config.pl" do
  owner "backuppc"
  group node['apache']['user']
  mode 0644
  source "config.pl"
  notifies :reload, "service[backuppc]"
end

hosts = search(:node, node['backuppc']['server']['hosts_search_query'],
               :filter_result => { 'fqdn' => [ 'fqdn' ] }).delete_if{ |host| host['fqdn'].nil? }

template "/etc/backuppc/hosts" do
  owner "backuppc"
  group node['apache']['user']
  mode 0644
  source "hosts.erb"
  notifies :reload, "service[backuppc]"
  variables({
    :hosts => hosts,
    :owner => node['backuppc']['server']['users'].keys().first(),
    :users => node['backuppc']['server']['users'].keys().drop(1).join(',')
  })
end

directory "/var/lib/backuppc/.ssh/" do
  recursive true
  owner "backuppc"
  group "backuppc"
  mode 0700
end

# prevent ssh host key caching/checking
file "/var/lib/backuppc/.ssh/config" do
  owner "backuppc"
  group "backuppc"
  mode 0644
  content <<-EOH.gsub(/^ +/, '')
    UserKnownHostsFile /dev/null
    StrictHostKeyChecking no
  EOH
end

# Create user account and SSH key
user_account "backuppc" do
  username "backuppc"
  home "/var/lib/backuppc"
  comment "BackupPC user"
  ssh_keygen true
end


#############################
# Apache
#############################

include_recipe "apache2"

web_app "#{node.fqdn}" do
  server_name "#{node.fqdn}"
  docroot "/var/www"
end

apache_site "default" do
  enable false
end

# redirect to /backuppc/
file "/var/www/.htaccess" do
  mode 0644
  content <<-EOH.gsub(/^ +/, '')
    RewriteEngine On
    RewriteRule ^$ /backuppc/ [R=301]
  EOH
end

template "/etc/backuppc/htpasswd" do
  source "htpasswd.erb"
  owner "backuppc"
  group node['apache']['user']
  mode 0644
end


#############################
# Monitoring
#############################

if node.recipe?('zabbix::agent')

  template "#{node.zabbix.external_dir}/backuppc.pl" do
    source "zabbix-backuppc.pl"
    mode "755"
  end

  cron "zabbix-backuppc" do
    command "#{node.zabbix.external_dir}/backuppc.pl > /dev/null"
    minute "*/10"
    user "backuppc"
  end
end
