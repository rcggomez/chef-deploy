n EC2 clonar el repo y ejecutar
Ya en tu nueva instancia EC2:

cd ~
git clone https://github.com/tu_usuario/chef-sai-deploy.git chef-repo
cd chef-repo

# Ejecutar el deploy
sudo chef-solo -c solo.rb -o 'recipe[sai_deploy::deploy_app]'
