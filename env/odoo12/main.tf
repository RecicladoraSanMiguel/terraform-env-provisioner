resource "random_string" "random" {
  length = 8
  upper = false
  special = false
}

locals {
  env_id = var.env_id != "" ? var.env_id : random_string.random.result
}

data "terraform_remote_state" "setup" {
  backend = "local"

  config = {
    path = "../../setup/terraform.tfstate"
  }
}

module "docker_provider" {
  source = "../../modules/docker/provider"
  docker_host_user = var.global__docker_host_user
  docker_host_password = var.global__docker_host_password
}

module "env_network" {
  source = "../../modules/docker/network"
  env_id = local.env_id
  network_name = "${local.env_id}_network"
  internal_only = false
  is_attachable = true
}

module "postgres_12_instance" {
  source = "../../modules/environment"
  base_volumes_path = var.base_volumes_path
  env_id = local.env_id
  container_name = "postgres"
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
  networks = [module.env_network.network_name]
}

module "odoo12_instance" {
  source = "../../modules/environment"
  base_volumes_path = var.base_volumes_path
  env_id = local.env_id
  container_name = "odoo12"
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
  networks = [data.terraform_remote_state.setup.outputs.gateway_network, module.env_network.network_name]
}

module "vhost" {
  source = "../../modules/nginx_vhosts/proxy"
  vhost_destination_path = data.terraform_remote_state.setup.outputs.nginx-gateway_vhosts_folder_path
  vhost_hostname = "${local.env_id}.recsm.com"
  upstream = {
    name = module.odoo12_instance.container_name
    port = 8069
  }
}
