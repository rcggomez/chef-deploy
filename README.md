# 📦 sai_deploy

#Automatización del despliegue de una aplicación Node.js con base de datos PostgreSQL utilizando **Chef Workstation** en modo local.

## 🚀 Características principales
- Instalación automatizada de Node.js (v18.x)
- Configuración de PostgreSQL con restauración de base de datos
- Despliegue de aplicación empaquetada
- Gestión de procesos con PM2
- Configuración de variables de entorno
- Compatibilidad con múltiples entornos

## 🖥️ Compatibilidad
- **Sistemas operativos**: Ubuntu Server 20.04+
- **Entornos soportados**:
  - Máquinas virtuales locales (VirtualBox/Vagrant)
  - Instancias en la nube (AWS EC2, Google Cloud, etc.)
  - Servidores físicos

## 📁 Estructura del proyecto
```
sai_deploy/
├── cookbooks/
│ └── sai_deploy/
│ ├── recipes/
│ │ ├── nodejs.rb
│ │ ├── postgresql.rb
│ │ └── deploy_app.rb
│ ├── files/
│ │ ├── default/
│ │ │ ├── sai_alterno_package.tar.gz
│ │ │ └── schema.sql
│ ├── templates/
│ │ └── default/
│ │ └── env.erb
│ └── metadata.rb
├── solo.rb
└── README.md
```

## ⚙️ Requisitos previos
- [Chef Workstation](https://downloads.chef.io/) instalado
- Ubuntu Server 20.04+ como máquina destino
- Acceso sudo/root en el nodo
- Conexión SSH (para despliegues remotos)
- Aplicación empaquetada como `.tar.gz` con:
  - `package.json` válido
  - Estructura de directorios correcta

## 🛠️ Instalación

### Opción 1: Despliegue en VM local
1. Clona el repositorio:
   ```
   git clone https://github.com/tu-usuario/sai_deploy.git
 
Inicia tu VM Ubuntu y copia los archivos:

```
scp -r sai_deploy/ usuario@ip-vm:/home/usuario/
```
Ejecuta las recetas:

```
sudo chef-solo -c /home/usuario/sai_deploy/solo.rb -o 'recipe[sai_deploy]'
```
### Opción 2: Despliegue en AWS EC2
Crea una instancia EC2 con Ubuntu 20.04+

Conéctate via SSH:

```bash
ssh -i "tu-key.pem" ubuntu@ec2-ip
```
Clona y ejecuta:

```bash
git clone https://github.com/tu-usuario/sai_deploy.git
cd sai_deploy
sudo chef-solo -c solo.rb -o 'recipe[sai_deploy]'
```
###🔍 Verificación del despliegue
```bash
# Verificar estado de la aplicación
pm2 list

# Verificar base de datos
sudo -u postgres psql -d db_sai_alterno -c "\dt"

# Verificar servicio
curl http://localhost:3000/health

# Ejecutar el deploy
sudo chef-solo -c solo.rb -o 'recipe[sai_deploy::deploy_app]'
```
