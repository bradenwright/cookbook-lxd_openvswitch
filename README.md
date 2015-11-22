# lxd_openvswitch-cookbook

This cookbook is still under development.  It will:

* Install LXD, OpenVSwitch (DONE)
* Configure physical interface on OVS bridge (allow internet access)
* Setup ovsdown.sh script, work around for bug
* Vlan Support (create interfaces, create ovs fake bridge)
* Inter-vlan routing in Linux Kernel (on Linux host)
* VXLan Support (multi-host container network)
* Optionally clean up unnecessary config from default lxbr0, etc
* Configure LXD options like remote password, add remotes from chef search, etc.a
* Thanks to for OpenVSwitch Tutorials/Blogs [Scott Lowe](http://blog.scottlowe.org/2014/01/23/automatically-connecting-lxc-to-open-vswitch/)

I'm going to use all of the above options.  I'll use this recipe to setup/install Ubuntu Servers that are to act as hosts for LXD containers (in virtualization lingo hypervisors).

## Supported Platforms

Ubuntu 15.10+

## Attributes

## Usage

### lxd_openvswitch::default

Include `lxd_openvswitch` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[lxd_openvswitch]"
  ]
}
```

## License and Authors

Author:: Braden Wright (<braden.m.wright@gmail.com>)
