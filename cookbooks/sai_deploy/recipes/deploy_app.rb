#
# Cookbook:: sai_deploy
# Recipe:: deploy_app
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# Crear directorio base
directory '/opt/sai_alterno' do
  recursive true
end

# Copiar paquete comprimido
cookbook_file '/opt/sai_alterno_package.tar.gz' do
  source 'sai_alterno_package.tar.gz'
  owner 'root'
  group 'root'
  mode '0644'
end

# Descomprimir dentro del directorio
execute 'untar app' do
  cwd '/opt'
  command 'tar -xzf sai_alterno_package.tar.gz -C sai_alterno --strip-components=1'
  not_if { ::File.exist?('/opt/sai_alterno/package.json') }
end

# Copiar archivo .env
template '/opt/sai_alterno/.env' do
  source 'env.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

# Copiar esquema SQL
cookbook_file '/tmp/schema.sql' do
  source 'schema.sql'
  owner 'postgres'
  group 'postgres'
  mode '0644'
end

# Crear base de datos
execute 'create database' do
  command "sudo -u postgres psql -c \"DROP DATABASE IF EXISTS db_sai_alterno; CREATE DATABASE db_sai_alterno WITH OWNER postgres;\""
end

# Asignar contraseña al usuario postgres (solo si no tiene)
execute 'set postgres user password' do
  command "sudo -u postgres psql -c \"ALTER USER postgres WITH PASSWORD 'admin';\""
  # Esta condición evita reasignar la contraseña si ya está establecida
  not_if "sudo -u postgres psql -tAc \"SELECT 1 FROM pg_shadow WHERE usename='postgres' AND passwd IS NOT NULL\" | grep 1"
end

# Restaurar esquema en la base de datos
execute 'restore schema' do
  command "sudo -u postgres psql -d db_sai_alterno -f /tmp/schema.sql"
end

# Instalar dependencias npm
execute 'npm install' do
  cwd '/opt/sai_alterno'
  command 'npm install'
end

# Ejecutar aplicación en background
execute 'start app' do
  cwd '/opt/sai_alterno'
  command 'npm start &'
end

