#
# Cookbook Name:: lxd_openvswitch
# Recipe:: default
#
# Copyright (C) 2015 Braden Wright
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'lxd_openvswitch::_base'

# [:lxd_openvswitch][:lxd_version]
package 'lxd' do
  version node[:lxd_openvswitch][:lxd_version]
end

%w{ openvswitch-switch openvswitch-common }.each do |pkg|
  package pkg
end
=begin
node[:lxd_openvswitch][:bridges].each do |br|
  info("create br: #{br}")
end
=end
