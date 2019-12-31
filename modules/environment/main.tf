module "docker_image" {
  source = "../docker/image"
  image_name = var.container_image_name
  keep_image_locally = var.keep_image_locally
}

module "container_paths" {
  source = "../docker/mounts"
  base_env_path = var.base_env_path
  env_id = var.env_id
  service_type = var.service_type
  mounts = var.mounts
}

module "docker_container" {
  source = "../docker/container"
  env_id = var.env_id
  service_type = var.service_type
  container_name_suffix = var.container_name_suffix
  image_id = module.docker_image.image_id
  run_as_privileged = var.run_as_privileged
  networks = var.networks
  ports = var.ports
  volumes = module.container_paths.mounts
  env_vars = var.env_vars
}
