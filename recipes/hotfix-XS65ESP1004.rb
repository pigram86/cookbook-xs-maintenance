#
# Cookbook Name:: xs_maintenance
# Recipe:: hotfix-XS62ESP1004
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

# CVE-2015-4106, CVE-2015-4163, CVE-2015-4164, CVE-2015-2756, CVE-2015-4103, CVE-2015-4104, CVE-2015-4105
bash "install XS65ESP1004" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  mkdir -p /tmp/hotfixes
  cd /tmp/hotfixes

  wget http://downloadns.citrix.com.edgesuite.net/10663/XS65ESP1004.zip
  unzip XS65ESP1004.zip

  . /etc/xensource-inventory

  PATCHUUID=$(xe patch-upload file-name=XS65ESP1004.xsupdate)
  xe patch-pool-apply uuid=${PATCHUUID}

  xe patch-clean uuid=${PATCHUUID}
  EOH
  not_if {::File.exists?(node['xs65sp1']['004'])}
end