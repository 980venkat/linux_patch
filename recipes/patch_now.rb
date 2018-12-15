#
# Cookbook:: linux_patch
# Recipe:: patch_now
#
# Copyright:: 2018, The Authors, All Rights Reserved.

begin
  tag_method = method(:tag)

  if tagged?('do_not_patch')
    log 'This node has the do_not_patch tag in Chef, skipping all patching as instructed...'
    return
  end

  # if chef tag patch_now exists, invoke immediate patching...
  if tagged?('patch_now')
    include_recipe 'linux_patch::patch_now'
  end
  
rescue Exception => e
  log e.message
  log e.backtrace
  log 'An error occured inpatching'
  return
end

