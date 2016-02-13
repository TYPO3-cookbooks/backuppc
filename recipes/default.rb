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
  ssh_keys [
    "command=\"sudo $SSH_ORIGINAL_COMMAND\" ssh-dss AAAAB3NzaC1kc3MAAACBAOPVf4NG1jtLd4842teaVOa1hsjkBzbpTxpEoJHMHVKqyirRB4fuCFRWxoCdn+Mto78XVc7F7rNz+1ZiHPEWGJIhfnbbpC9X2+zK9ArihGusyT+oGDsN7mr3IikyUTrR3N58Nq2caRoih7BzM6AIDzJ8D8h42m026J9llSzF5r5dAAAAFQCuFqc4K8zYMwnpgmvkdLDnidnTpQAAAIEA1mLKcg5oLZ3u1W7w9Z2wcF0FpEAKMj+ZNG/MbxowTq7LmL5HTn9Zz8nDRWEwYDIEEt3Nx3xhkbjKEqO+jGjdl5HxRYorsXdOQng1iLHkpG2FyFZg8cac0yyggGhVDGmvc/F0PI91a2TpKBvbQUfMlEDuVQhbki8o62N3zBpx4y4AAACAArWnTOQ8gySaC0EcvGLy9I93PhxSPtyEtfJzO7IHo7XdM7vOFLHEGJeCsLklbfbgVAux+/ByZiLd2cOxUA2yqfw4zU4w1D3BKNCtyEfMmxGIWN9eeyN+JtWLv4kO6qp5bYx0XRVJLLJ4+QmJELPaItSdR/8mPZXuu+th7SRAZso= old-key@mstucki",
    "command=\"sudo $SSH_ORIGINAL_COMMAND\" ssh-dss AAAAB3NzaC1kc3MAAACBAIV5OCUoJjsYLZ5kN/hEmUkcrJw/sLS+VTXg7N0HBVNChwgZEW/uizYbEcl/OWi0HplVYfG3WX1u8X6wWhajrxrTizMaNGoVvUXur/s/SNEW6fg6JKPrIswV0NuWyrwPmzO9582KAa7WU7sBIO0FpiadcU+Srz+eUUap1dYH2eHvAAAAFQCjn7rZdpaoqIbbQJIo2ZlygVt+JwAAAIBcIosaN7RR3Ytc4Fx58do18tSlsFqoQuiafh6iof73hPP/cEwWQRDgXzfmcmkgZne4ijc39TcZAinOJNAO4Em4H4BuPsKyjLj1ST6slvGWtHxyXxrca9yeNSMnOdn2ZhQU7caFqb1nee1m6UlpuBvHz5MShYCpvpAyDtNjxXbg0QAAAIAf6RUuCpR4/uCMtL5mJ53HKBlmVHmF2RemjpcOetb+xGTZHkG9ikMePNQTn23mpLW+ZguI6TIpBkeYUyPj0OT6im+PgOaN7iQOngCINCGnC9+aMKnCIvk3lLs77fcNYKhKZOLZm6O3ODhKkBKN9GJNCVB/qOEjhd5mECJrSWytEA== backuppc@backup01.typo3.org-2012-10-30T08:19:12+0100"
  ]
  ssh_keygen false
end

# Add file to sudoers folder to allow only `rsync` for this user
template "/etc/sudoers.d/backuppc-#{node.backuppc.user}" do
  source "sudoers.erb"
  mode "440"
end
