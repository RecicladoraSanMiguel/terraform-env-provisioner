module "docker_provider" {
  source = "../modules/docker/provider"
  docker_host_ip = var.global__docker_host_ip
}

module "docker_global_networks" {
  source = "../modules/docker/network"
}

module "docker_global_images" {
  source = "../modules/docker/image"
}

module "global_proxy" {
  source = "../modules/docker/container"

}