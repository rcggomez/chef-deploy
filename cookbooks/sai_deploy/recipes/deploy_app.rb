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

# SECCIÓN POSTGRESQL MEJORADA
bash 'setup_postgresql' do
  user 'root'
  code <<-EOH
    # Comandos separados para evitar problemas de transacción
    sudo -u postgres psql -c "DROP DATABASE IF EXISTS db_sai_alterno"
    sudo -u postgres psql -c "CREATE DATABASE db_sai_alterno WITH OWNER postgres"
    
    # Configurar contraseña solo si es necesario
    if ! sudo -u postgres psql -tAc "SELECT 1 FROM pg_shadow WHERE usename='postgres' AND passwd IS NOT NULL" | grep -q 1; then
      sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'admin'"
    fi
    
    # Restaurar esquema
    sudo -u postgres psql -d db_sai_alterno -f /tmp/schema.sql
  EOH
end

# Instalar dependencias npm
execute 'npm install' do
  cwd '/opt/sai_alterno'
  command 'npm install'
  environment 'PATH' => "/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
end

# Ejecutar aplicación en background usando PM2 (recomendado)
execute 'install pm2' do
  command 'npm install -g pm2'
  not_if 'which pm2'
end

execute 'start app with pm2' do
  cwd '/opt/sai_alterno'
  command 'pm2 start npm --name "sai_alterno" -- start'
  not_if 'pm2 list | grep sai_alterno'
end

# Configurar inicio automático
execute 'pm2 startup' do
  command 'pm2 startup'
  not_if 'pm2 status | grep "online"'
end

execute 'pm2 save' do
  command 'pm2 save'
end