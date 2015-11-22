require 'serverspec'

# Required by serverspec
set :backend, :exec

describe "lxd_openvswitch base install" do

  %w{ vim build-essential }.each do |pkg|
    it "Package #{pkg} installed" do
      expect(package(pkg)).to be_installed
    end
  end

end
