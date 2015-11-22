#
# Cookbook Name:: lxd_openvswitch
# Recipe:: _base
#
# Copyright (C) 2015 Braden Wright
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
package 'vim'
include_recipe "build-essential"

