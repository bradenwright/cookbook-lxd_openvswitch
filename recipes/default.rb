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

if node[:lxd_openvswitch][:enable_intervlan_routing]
  bash "enable inter-vlan routing" do
    code "sysctl -w net.ipv4.ip_forward=1"
  end

  # FileEdit /etc/sysctl.conf
  #net.ipv4.ip_forward=1
end

template "/etc/network/interfaces" do
  source "network_interfaces.erb"
end


node[:lxd_openvswitch][:bridges].each do |key, value|
  bash "create ovs bridge #{key}" do
    code "ovs-vsctl --may-exist add-br #{key}"
  end

  # Configure ip if supplied
end

node[:lxd_openvswitch][:vlans].each do |key, value|
  bash "create ovs fake bridge #{key}" do
    code "ovs-vsctl --may-exist add-br #{key} #{value[:parent_ovs_bridge]} #{value[:id]}"
  end

  template "/etc/network/interfaces.d/#{key}.cfg" do
    source "interface.cfg.erb"
    variables( 
      :vlan_name => key,
      :ipv4 => value[:ipv4],
      :ip_method => "static", #static, dhcp manual
    )
    notifies :run, "bash[stop interface #{key}]", :immediately
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

end

template "/etc/lxc/ifdown_ovs_bug_fix.sh" do
  mode "551"
  source "lxc_ifdown_ovs_bug_fix.sh.erb"
end

