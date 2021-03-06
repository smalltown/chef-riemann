# recipes/dashboard.rb
#
# Author: Simple Finance <ops@simple.com>
# License: Apache License, Version 2.0
#
# Copyright 2013 Simple Finance Technology Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Sets up the dashboard for Riemann

directory node[:riemann][:dashboard][:directory] do
  owner 'riemann'
  group 'riemann'
  mode 00755
  recursive true
  action :create
end

template ::File.join(node[:riemann][:dashboard][:directory], 'config.rb') do
  owner 'riemann'
  group 'riemann'
  mode 00755
  variables(
    :port => node[:riemann][:dashboard][:port] )
  action :create
end

gem_package 'thin' do
  action :install
end

gem_package 'riemann-dash' do
  action :install
end

runit_service 'riemann-dash' do
#  env node[:riemann][:dashboard][:env]
  default_logger true
  options(
    :rubies => node[:rbenv][:rubies], 
    :envdir => "#{node[:rbenv][:root_path]}/versions/#{node[:rbenv][:rubies]}/bin",
    :confdir => node[:riemann][:dashboard][:directory] )
  action [:enable, :start]
end

