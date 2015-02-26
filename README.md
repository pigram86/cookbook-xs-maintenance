Description
===========

This cookbook is for XenServer 6.x and includes maintenance tasks as well as patches

Supported Platforms
===================

* XenServer 6.1

* XenServer 6.2

* XenServer 6.5

Cookbooks
=========

* No dependecies

Recipes
=======

Each patch has its own recipe in the following format. Using attributes for idempotence.

* bash "install XS61E030" do
*  user "root"
*  cwd "/tmp"
*  code <<-EOH
*  mkdir -p /tmp/hotfixes
*  cd /tmp/hotfixes

*  wget http://downloadns.citrix.com.edgesuite.net/8155/XS61E030.zip
*  unzip XS61E030.zip
*
*  . /etc/xensource-inventory
*
*  PATCHUUID=$(xe patch-upload file-name=XS61E030.xsupdate)
*  xe patch-pool-apply uuid=${PATCHUUID}
*
*  xe patch-clean uuid=${PATCHUUID}
*  EOH
*  not_if {::File.exists?(node['hf']['030'])}
* end


* XenServer 6.1 Patches
=======================

hotfix-XS61E030.rb
------------------

hotfix-XS61E038.rb
------------------

hotfix-XS61E039.rb
------------------

hotfix-XS61E040.rb
------------------

hotfix-XS61E041.rb
------------------

hotfix-XS61E043.rb
------------------

hotfix-XS61E044.rb
------------------

hotfix-XS61E045.rb
------------------

* XenServer 6.2 Patches
=======================

hotfix-XS62ESP1.rb
------------------

hotfix-XS62ESP1003.rb
---------------------

hotfix-XS62ESP1008.rb
---------------------

hotfix-XS62ESP1009.rb
---------------------

hotfix-XS62ESP1012.rb
---------------------

hotfix-XS62ESP1014.rb
---------------------

hotfix-XS62ESP1016.rb
---------------------
### Includes XS62ESP1008, XS62ESP1011, XS62ESP1013 & XS62ESP1015

hotfix-XS62ESP1017.rb
---------------------
### CVE Ghost

* XenServer 6.5 Patches
=======================

hotfix-XS65E002.rb
------------------
## XenTools (PV Drivers) Fix


hotfix-XS65E003.rb
------------------
### CVE Ghost

* Maintenance
==============

hotfixCleanup.rb
----------------

* bash "cleanup" do
*   user "root"
*   code <<-EOH
*   rm -rf /tmp/hotfixes
*   EOH
*   only_if {::File.exists?(node['hf']['dir'])}
* end

rootdiskmaintenance.rb
----------------------

* template "/root/diskmonitor.sh" do
*   source "diskmonitor.sh.erb"
*   owner "root"
*   group "root"
*   mode "0777"
* end

* cron "diskmonitor" do
*   hour "0"
*   minute "0"
*   command "/root/diskmonitor"
* end

* cron "diskmonitor" do
*   hour "6"
*   minute "0"
*   command "/root/diskmonitor"
* end

* cron "diskmonitor" do
*   hour "12"
*   minute "0"
*   command "/root/diskmonitor"
* end

* cron "diskmonitor" do
*   hour "18"
*   minute "0"
*   command "/root/diskmonitor"
* end

* In development
================

xs_logrotate_conf.rb
--------------------

* template "/etc/logrotate.conf" do
*   source "logrotate.conf.erb"
*   owner "root"
*   group "root"
*   mode "0755"
* end

ccp_logrotate.rb
----------------

ccp_xs_logrotate.rb
-------------------

Attributes
==========

# Make hotfixes directory

* default['hf']['dir'] = '/tmp/hotfixes'

* #XenServer 6.2 SP1 & Post SP1 hotfixes
* default['hf']['sp1'] = "/var/patch/applied/0850b186-4d47-11e3-a720-001b2151a503"
* default['hf']['1003'] = "/var/patch/applied/c208dc56-36c2-4e91-b8d7-0246575b1828"
* default['hf']['1008'] = "/var/patch/applied/59a75271-12f9-4e6a-8ba2-325c2f5b0b47"
* default['hf']['1009'] = "/var/patch/applied/a24d94e1-326b-4eaa-8611-548a1b5f8bd5"
* default['hf']['1011'] = "/var/patch/applied/7d670435-547c-419a-ab7e-296705a752b8"
* default['hf']['1012'] = "/var/patch/applied/a26964cf-a409-46a4-b94c-66bf6083690f"
* default['hf']['1013'] = "/var/patch/applied/b22d6335-823d-43a6-ba26-28793717125b"
* default['hf']['1014'] = "/var/patch/applied/4fc82e62-b938-407d-a2c6-68c8922f3ec2"
* default['hf']['1015'] = "/var/patch/applied/f4f66d0a-d408-446e-a014-8e793baccb07"
* default['hf']['1016'] = "/var/patch/applied/55444a02-4d97-4d6d-b076-ddbe8697244b"
* default['hf']['1017'] = "/var/patch/applied/902607f2-6186-464b-bcb8-86559602ab58"

* #XenServer 6.5 Hotfixes
* default['hf']['002'] = "/var/patch/applied/0fedb090-7d7a-4dce-afac-34d56d4c9aff"
* default['hf']['003'] = "/var/patch/applied/5200911d-5f79-4149-abca-0556af77b14d"

* #XenServer 6.1 Hotfixes
* default['hf']['043'] = "/var/patch/applied/f741fd18-3331-446a-8263-9c01b0799cc3"
* default['hf']['030'] = "/var/patch/applied/"
* default['hf']['038'] = "/var/patch/applied/"
* default['hf']['039'] = "/var/patch/applied/"
* default['hf']['040'] = "/var/patch/applied/"
* default['hf']['041'] = "/var/patch/applied/"
* default['hf']['044'] = "/var/patch/applied/946d4291-ed24-4330-ac06-3b4e4e5b75f8"
* default['hf']['045'] = "/var/patch/applied/37a73ca4-c1db-4307-8144-7020e072e5e4"

* # Logrotate
* default['setup43']['path'] = "/usr/share/cloudstack-common/scripts/vm/hypervisor/xenserver/"
* default['setup43']['change'] = "[ -f /etc/cron.hourly/logrotate ] || mv /etc/cron.daily/logrotate /etc/cron.hourly 2>&1"
* default['setup42']['path'] = "/usr/lib64/cloud/agent/scripts/vm/hypervisor/xenserver/"
* default['setup']['xs62'] = "/opt/cloud/bin/"
* default['setup']['xs61'] = "/opt/xensource/bin/"

Templates
=========

diskmonitor.sh.erb
------------------

logrotate.conf.erb
------------------

logrotate.erb
-------------

setupxenserver.sh.erb
---------------------


Usage
=====

Depending on the version of assign the appropiate recipes to the nodes run list. I left reboots out of the recipes as to handle that manually

Include `xs_maintenance` in your node's `run_list`:

```json
 {
  "run_list": [
    "recipe[win_srv_default::default]"
   ]
 }
 ```


 Contributing
=============

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

License and Authors
===================

Author:: Todd Pigram (<todd@toddpigram.com>)

Copyright:: 2013-2015, Todd Pigram

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

