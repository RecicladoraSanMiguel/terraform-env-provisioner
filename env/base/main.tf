resource "random_string" "random" {
  length = 8
  upper = false
  special = false
}

locals {
  env_id = var.env_id != "" ? var.env_id : random_string.random.result
  env_path = "${var.base_volumes_path}/${local.env_id}/"
}

module "env_base_folder" {
  source = "../../modules/local/folder"
  path = local.env_path
}

#@TODO: Enable terraform provider to save the state on the env folder
module "terraform_provider" {
  source = "../../modules/terraform/provider"
  env_path = module.env_base_folder.path_created
  depends = module.env_base_folder.to_depend
}

module "docker_provider" {
  source = "../../modules/docker/provider"
  docker_host = var.host_docker_ssh_hostname
  docker_host_port = var.host_docker_ssh_port
  docker_host_user = var.host_docker_ssh_user
  docker_host_password = var.host_docker_ssh_passwd
}

module "env_network" {
  source = "../../modules/docker/network"
  env_id = var.env_id
  internal_only = var.env_network_private
  is_attachable = var.env_network_attachable
}
