#
# Cookbook Name:: xs_maintenance
# Recipe:: hotfix-XS62ESP1019
#
# Copyright (C) 2015 Todd Pigram
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

### Contains XS62ESP1002, XS62ESP1004, XS62ESP1008, XS62ESP1011, XS62ESP1013, XS62ESP1015, XS62ESP1016
### CVE-2015-2044 (Medium): Information leak via internal x86 system device emulation
### CVE-2015-2045 (Medium): Information leak through version information hypercall
### CVE-2015-2151 (Medium): Hypervisor memory corruption due to x86 emulator flaw

bash "install XS62ESP1019" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  mkdir -p /tmp/hotfixes
  cd /tmp/hotfixes

  wget https://dl.dropboxusercontent.com/u/36379525/XS62ESP1019.zip
  unzip XS62ESP1019.zip

  . /etc/xensource-inventory

  PATCHUUID=$(xe patch-upload file-name=XS62ESP1019.xsupdate)
  xe patch-pool-apply uuid=${PATCHUUID}

  xe patch-clean uuid=${PATCHUUID}
  EOH
  not_if {::File.exists?(node['hf']['1019'])}
end