data "terraform_remote_state" "setup" {
  backend = "local"

  config = {
    path = "../../setup/terraform.tfstate"
  }
}

module "base_env" {
  source = "../base"
  env_id = var.env_id
  host_docker_ssh_hostname = var.global__docker_host
  host_docker_ssh_port = var.global__docker_host_port
  host_docker_ssh_user = var.global__docker_host_user
  host_docker_ssh_passwd = var.global__docker_host_password
  base_volumes_path = var.base_volumes_path
}

module "postgres_12_instance" {
  source = "../../modules/environment"
  base_env_path = module.base_env.env_path
  env_id = module.base_env.env_id
  container_name_suffix = "postgres12"
  service_type = "postgres"
  container_image_name = "postgres:12.1"
  keep_image_locally = true

  env_vars = [
    "POSTGRES_DB=${var.db_name}",
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}"
  ]

  mounts = [
    {
      host_folder_name = "data"
      container_path = "/var/lib/postgresql/data"
    }
  ]
  networks = [module.base_env.env_network_name]
}

module "odoo12_instance" {
  source = "../../modules/environment"
  base_env_path = module.base_env.env_path
  env_id = module.base_env.env_id
  container_name_suffix = "odoo12"
  service_type = "odoo"
  container_image_name = "odoo:12.0"
  keep_image_locally = true
  run_as_privileged = true

  env_vars = [
    "HOST=${module.postgres_12_instance.container_name}",
    "USER=${var.db_user}",
    "PASSWORD=${var.db_password}"
  ]

  mounts = [
    {
      host_folder_name = "extra_addons"
      container_path = "/mnt/extra-addons/"
    }
  ]
  networks = [data.terraform_remote_state.setup.outputs.gateway_network, module.base_env.env_network_name]
}

module "vhost" {
  source = "../../modules/nginx_vhosts/proxy"
  vhost_destination_path = data.terraform_remote_state.setup.outputs.nginx-gateway_vhosts_folder_path
  vhost_hostname = "${module.base_env.env_id}.recsm.com"
  is_secure = false
  upstream = {
    name = module.odoo12_instance.container_name
    port = 8069
  }
}
