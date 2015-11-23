#
# Cookbook Name:: lxd_openvswitch
# Attribute:: default
#
# Copyright (C) 2015 Braden Wright
#
# All rights reserved - Do Not Redistribute
#

default[:lxd_openvswitch][:lxd_version] = "0.20-0ubuntu4.1"
default[:lxd_openvswitch][:bridges] = {
  "vbr0" => { :ipv4 => "10.1.3.10/24", :interface => "eth1"  },
  "vbr1" => { }
}

default[:lxd_openvswitch][:vlans] = {
  "vlan10" => {
    :id => 10,
    :ipv4 => "10.1.10.10/24",
    :parent_ovs_bridge => "vbr0"
  },
  "vlan11" => {
    :id => 11,
    :ipv4 => "10.1.11.10/24",
    :parent_ovs_bridge => "vbr0"
  }

}

force_default[:apt][:compiletime] = true
force_default[:apt][:compile_time_update] = true
force_default['build-essential'][:compile_time] = true

