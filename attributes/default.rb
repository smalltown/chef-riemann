# attributes/default.rb

default[:riemann][:version] = '0.2.4'
case node[:platform]
when 'ubuntu' || 'debian'
  default[:riemann][:package] = "riemann_#{node[:riemann][:version]}_all.deb"
when 'fedora'
  default[:riemann][:package] = "riemann_#{node[:riemann][:version]}-1.noarch.rpm"
else
  default[:riemann][:package] = "riemann_#{node[:riemann][:version]}.tar.bz2"
end
default[:riemann][:package_url] = "http://aphyr.com/riemann/#{node[:riemann][:package]}"

default[:riemann][:user][:name] = 'riemann'
default[:riemann][:user][:home] = '/home/riemann'
default[:riemann][:user][:shell] = '/bin/bash'

default[:riemann][:server][:host] = 'localhost'
default[:riemann][:server][:port] = 5555

default[:riemann][:dashboard][:enable] = true
default[:riemann][:dashboard][:port] = 4567
default[:riemann][:dashboard][:directory] = '/opt/riemann-dash'
default[:riemann][:dashboard][:env] = {
  "PATH" => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/rbenv/shims"
}

default[:riemann][:health][:enable] = false
default[:riemann][:riak][:enable] = false

default[:rbenv][:rubies] = '2.1.1'

