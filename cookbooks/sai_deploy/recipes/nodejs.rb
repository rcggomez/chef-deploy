#
# Cookbook:: sai_deploy
# Recipe:: nodejs
#
# Copyright:: 2025, The Authors, All Rights Reserved.

apt_update 'update_apt_cache' do
  action :update
end

package 'curl'

execute 'add_nodesource_repo' do
  command 'curl -fsSL https://deb.nodesource.com/setup_18.x | bash -'
  not_if 'which node'
end

package 'nodejs' do
  action :install
end
