#
# Cookbook Name:: xs_maintenance
# Recipe:: hotfix-XS62ESP1008
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

# Includes XS65E009, XS65E010, XS65ESP1002, XS65ESP1004

bash "install XS65ESP1008" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  mkdir -p /tmp/hotfixes
  cd /tmp/hotfixes

  wget https://support.citrix.com/filedownload/CTX201637/XS65ESP1008.zip
  unzip XS65ESP1008.zip

  . /etc/xensource-inventory

  PATCHUUID=$(xe patch-upload file-name=XS65ESP1008.xsupdate)
  xe patch-pool-apply uuid=${PATCHUUID}

  xe patch-clean uuid=${PATCHUUID}
  EOH
  not_if {::File.exists?(node['xs65sp1']['008'])}
end

















