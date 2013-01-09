#
# Cookbook Name:: nfsmounts
# Recipe:: default
#
# Copyright 2013, Ninefold.com
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

# This needs to be installed for NFS to work
package "nfs-common"

node[:nfsmounts].each do |path, opts|
  # need a dir to mount to - create if not there
  directory path do
    owner 'root'
    group 'root'
    mode 755
    action :create
    recursive true
    not_if do ::File.exists?(path) && ::File.directory?(path) end
  end

  # Add it to FSTAB.
  mount path do
    device opts[:remote_path]
    fstype 'nfs'
    options opts[:options] ? opts[:options] : "rw"
    action [:enable]
  end

  # Mount if not already mounted
  mount path do
    device opts[:remote_path]
    fstype 'nfs'
    options opts[:options] ? opts[:options] : "rw"
    # Remount if things have changed
    action [:umount, :mount]
    # surround by spaces to prevent /mnt/vmguestlocal matching for /mnt/vmguest
    not_if "/bin/mount | grep ' #{path} ' | grep '#{opts[:remote_path]} '"
  end

end
