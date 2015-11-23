#
# Cookbook Name:: lxd_openvswitch
# Recipe:: default
#
# Copyright (C) 2015 Braden Wright
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'lxd_openvswitch::_base'

package 'lxd' do
  version node[:lxd_openvswitch][:lxd_version] if node[:lxd_openvswitch][:lxd_version]
end

%w{ openvswitch-switch openvswitch-common }.each do |pkg|
  package pkg
end

# FileEdit /etc/sysctl.conf
#net.ipv4.ip_forward=1

node[:lxd_openvswitch][:bridges].each do |key, value|
  Chef::Log.warn("create br: #{key}****************************************")

  bash "create ovs bridge #{key}" do
    code "ovs-vsctl --may-exist add-br #{key}"
  end
  # Configure ip if supplied

end

node[:lxd_openvswitch][:vlans].each do |key, value|
  template "/etc/network/interfaces.d/#{key}.cfg" do
    source "interface-vlan.cfg.erb"
    variables( 
      :vlan_name => key,
      :ipv4 => value[:ipv4],
      :ip_method => "static", #static, dhcp manual
    )
    notifies :run, "bash[stop interface #{key}]", :immediately
#    notifies stop interface, immediate action run
  end

  bash "stop interface #{key}" do
    code "ifdown #{key}"
    action :nothing
    only_if "ifconfig | grep -q #{key}"
  end

  bash "start interface #{key}" do
    code "ifup #{key}"
    not_if "ifconfig | grep -q #{key}"
  end

  bash "create ovs fake bridge #{key}" do
    code "ovs-vsctl --may-exist add-br #{key} #{value[:parent_ovs_bridge]} #{value[:id]}"
  end
end

