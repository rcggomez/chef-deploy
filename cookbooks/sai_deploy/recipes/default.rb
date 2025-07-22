#
# Cookbook:: sai_deploy
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

#include_recipe 'sai_deploy::nodejs'
#include_recipe 'sai_deploy::postgresql'
#include_recipe 'sai_deploy::deploy_app'

#
# Cookbook:: sai_deploy
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# 1. Verificación previa del sistema
include_recipe 'sai_deploy::prerequisites'

# 2. Instalación de dependencias en orden estricto
include_recipe 'sai_deploy::nodejs' do
  retries 2
  retry_delay 30
end

include_recipe 'sai_deploy::postgresql' do
  retries 2
  retry_delay 30
  notifies :run, 'execute[wait_for_postgres]', :immediately
end

# 3. Esperar a que PostgreSQL esté completamente operativo
execute 'wait_for_postgres' do
  command 'until pg_isready -h 127.0.0.1; do sleep 2; done'
  action :nothing
end

# 4. Despliegue principal (con dependencias explícitas)
include_recipe 'sai_deploy::deploy_app' do
  subscribes :run, 'execute[wait_for_postgres]', :immediately
end