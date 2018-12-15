#
# Cookbook:: linux_patch
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

Chef::Log.info("Linux Patching")
Chef::Log.info("apply patch variable -- #{node['linux_patch']['apply_patch']}")
Chef::Log.info("exclude package variable -- #{node['linux_patch']['exclude_packages']}")


if node['linux_patch']['apply_patch']
  Chef::Log.info(" Updated falg is #{node['linux_patch']['apply_patch']} , Patching System.  ")
  exclude_packages = node['linux_patch']['exclude_packages'] 

  update_cmd = if exclude_packages.nil?
                 'yum update -y'
               elsif exclude_packages.empty?
                 'yum update -y'
               else
                 "yum --exclude=#{exclude_packages} update -y"
              end

bash 'installing patches on system' do
   code <<-EOC
    #yum update process not running
    if [[ $(ps -ef | grep "; yum update" | grep -cv grep) == 0 ]]; then
      #{update_cmd}
      yum install yum-utils  -y
      package-cleanup --oldkernels --count=1
    fi
    EOC
  end 
else
   Chef::Log.info(" Updated flag is #{node['linux_patch']['apply_patch']} , Skiping patches..  ")
end
Chef::Log.info(" Ending linux patching ")
