require 'spec_helper'

describe 'lxd_openvswitch::_base' do
  let(:chef_run) {
    ChefSpec::SoloRunner.new(:platform => 'ubuntu', :version => '15.04').converge described_recipe
#    ChefSpec::ServerRunner.new(:platform => 'ubuntu', :version => '14.04').converge described_recipe

  }

  it 'includes recipe apt' do
    expect(chef_run).to include_recipe('apt')
  end

  it 'installs vim package' do
    expect(chef_run).to install_package('vim')
  end

  it 'includes recipe build-essential' do
    expect(chef_run).to include_recipe('build-essential')
  end

  it 'installs build-essential package' do
    expect(chef_run).to install_package('build-essential')
  end
end
