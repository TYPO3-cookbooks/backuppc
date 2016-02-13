#
# Cookbook Name:: backuppc
# Recipe:: default
#
# Copyright 2012, TYPO3 Association
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

# Create user account
user_account node['backuppc']['user'] do
  username node['backuppc']['user']
  comment "BackupPC user"
  ssh_keys node['backuppc']['user_ssh_pubkeys']
  ssh_keygen false
end

# Add file to sudoers folder to allow only `rsync` for this user
template "/etc/sudoers.d/backuppc-#{node.backuppc.user}" do
  source "sudoers.erb"
  mode "440"
end
