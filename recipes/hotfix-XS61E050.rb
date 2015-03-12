#
# Cookbook Name:: xs_maintenance
# Recipe:: hotfix-XS61E050
#
# Copyright (C) 2014 Todd Pigram
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

## Includes XS61E003, XS61E004, XS61E006, XS61E009, XS61E012, XS61E013, XS61E017, XS61E019, XS61E020, XS61E022, XS61E024, XS61E026, XS61E027, XS61E032, XS61E033, XS61E036, XS61E037, XS61E041, XS61E043, XS61E045, XS61E046
### CVE-2015-2044 (Medium): Information leak via internal x86 system device emulation
### CVE-2015-2045 (Medium): Information leak through version information hypercall
### CVE-2015-2151 (Medium): Hypervisor memory corruption due to x86 emulator flaw

bash "install XS61E050" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  mkdir -p /tmp/hotfixes
  cd /tmp/hotfixes

  wget http://downloadns.citrix.com.edgesuite.net/10205/XS61E050.zip
  unzip XS61E050.zip

  . /etc/xensource-inventory

  PATCHUUID=$(xe patch-upload file-name=XS61E050.xsupdate)
  xe patch-pool-apply uuid=${PATCHUUID}

  xe patch-clean uuid=${PATCHUUID}
  EOH
  not_if {::File.exists?(node['hf']['050'])}
end