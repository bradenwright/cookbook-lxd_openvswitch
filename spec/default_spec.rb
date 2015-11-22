require 'spec_helper'

describe 'lxd_openvswitch::default' do
  let(:chef_run) {
    ChefSpec::SoloRunner.new(:platform => 'ubuntu', :version => '15.04').converge described_recipe
#    ChefSpec::ServerRunner.new(:platform => 'ubuntu', :version => '15.04').converge described_recipe
  }

  it 'includes recipe lxd_openvswitch::_base' do
    expect(chef_run).to include_recipe('lxd_openvswitch::_base')
  end

  it 'installs lxd' do
    expect(chef_run).to install_package('lxd') 
  end

  it 'installs openvswitch-switch' do
    expect(chef_run).to install_package('openvswitch-switch')
  end

  it 'installs openvswitch-common' do
    expect(chef_run).to install_package('openvswitch-common')
  end
end
