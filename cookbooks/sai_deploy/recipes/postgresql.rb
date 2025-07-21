#
# Cookbook:: sai_deploy
# Recipe:: postgresql
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# Instala PostgreSQL y sus herramientas
package 'postgresql'
package 'postgresql-contrib'

# Habilita e inicia el servicio
service 'postgresql' do
  action [:enable, :start]
end

# Crea la base de datos si no existe
bash 'create_database' do
  user 'postgres'
  code <<-EOH
    psql -tc "SELECT 1 FROM pg_database WHERE datname = 'db_sai_alterno'" | grep -q 1 || \
    psql -c "CREATE DATABASE db_sai_alterno OWNER postgres;"
  EOH
end

