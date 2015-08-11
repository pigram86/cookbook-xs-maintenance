#
# Cookbook Name:: xs_maintenance
# Recipe:: hotfix-XS62ESP1031
#
# Copyright (C) 2015 Todd Pigram, All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Includes the following Hotfixes - XS62E014, XS62ESP1002, XS62ESP1004, XS62ESP1008, XS62ESP1011, XS62ESP1013, XS62ESP1015, XS62ESP1016, XS62ESP1019, XS62ESP1021, XS62ESP1025, XS62ESP1026, XS62ESP1027, XS62ESP1030

bash "install XS62ESP1031" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  mkdir -p /tmp/hotfixes
  cd /tmp/hotfixes

  wget http://support.citrix.com/filedownload/CTX201763/XS62ESP1031.zip
  unzip XS62ESP1031.zip

  . /etc/xensource-inventory

  PATCHUUID=$(xe patch-upload file-name=XS62ESP1031.xsupdate)
  xe patch-pool-apply uuid=${PATCHUUID}

  xe patch-clean uuid=${PATCHUUID}
  EOH
  not_if {::File.exists?(node['xs62sp1']['031'])}
end