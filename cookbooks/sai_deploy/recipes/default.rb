#
# Cookbook:: sai_deploy
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

include_recipe 'sai_deploy::nodejs'
include_recipe 'sai_deploy::postgresql'
include_recipe 'sai_deploy::deploy_app'
