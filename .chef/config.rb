current_dir = File.dirname(__FILE__)
cookbook_path ["#{current_dir}/../cookbooks"]

knife[:ssh_user] = "dev"
knife[:ssh_password] = "operaciones"
knife[:use_sudo] = true