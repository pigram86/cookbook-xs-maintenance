#
# Cookbook Name:: xs_maintenance
# Recipe:: hotfix-XS62ESP1002
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

# VENOM - CVE-2015-3456: http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-3456
bash "install XS65ESP1002" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  mkdir -p /tmp/hotfixes
  cd /tmp/hotfixes

  wget http://downloadns.citrix.com.edgesuite.net/10566/XS65ESP1002.zip
  unzip XS65ESP1002.zip

  . /etc/xensource-inventory

  PATCHUUID=$(xe patch-upload file-name=XS65ESP1002.xsupdate)
  xe patch-pool-apply uuid=${PATCHUUID}

  xe patch-clean uuid=${PATCHUUID}
  EOH
  not_if {::File.exists?(node['xs65sp1']['002'])}
end


















