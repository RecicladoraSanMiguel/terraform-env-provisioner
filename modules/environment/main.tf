module "docker_image" {
  source = "../docker/image"
  image_name = var.container_image_name
  keep_image_locally = var.keep_image_locally
}

module "docker_container" {
  source = "../docker/container"
  base_volumes_path = var.base_volumes_path
  env_id = var.env_id
  service_type = var.service_type
  container_name = var.container_name
  image_id = module.docker_image.image_id
  run_as_privileged = var.run_as_privileged
  networks = var.networks

  volumes = var.volumes
}
