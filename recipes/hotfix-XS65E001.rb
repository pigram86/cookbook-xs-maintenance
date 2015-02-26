#
# Cookbook Name:: xs_maintenance
# Recipe:: hotfix-XS65E001
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

### Server Side XenCenter update

bash "install XS65E001" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  mkdir -p /tmp/hotfixes
  cd /tmp/hotfixes

  wget http://downloadns.citrix.com.edgesuite.net/10194/XS65E001.zip
  unzip XS65E001.zip

  . /etc/xensource-inventory

  PATCHUUID=$(xe patch-upload file-name=XS65E001.xsupdate)
  xe patch-pool-apply uuid=${PATCHUUID}

  xe patch-clean uuid=${PATCHUUID}
  EOH
  not_if {::File.exists?(node['hf']['001'])}
end