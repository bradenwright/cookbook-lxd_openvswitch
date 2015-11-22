require 'serverspec'

# Required by serverspec
set :backend, :exec

describe "default lxd_openvswitch" do

  %w{ lxd openvswitch-switch openvswitch-common }.each do |pkg|
    it "Package #{pkg} installed" do
      expect(package(pkg)).to be_installed
    end
  end

end
