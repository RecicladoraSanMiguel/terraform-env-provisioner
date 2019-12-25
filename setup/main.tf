module "docker_provider" {
  source = "../modules/docker/provider"
  docker_host_user = var.global__docker_host_user
  docker_host_password = var.global__docker_host_password
}

module "global_network_gateway" {
  source = "../modules/docker/network"
  env_id = var.env_id
  network_name = "gateway"
  internal_only = false
  is_attachable = true
}

module "certbot_global_instance" {
  source = "../modules/environment/"
  env_id = var.env_id
  container_name = "global"
  service_type = "certbot"
  container_image_name = "henridwyer/docker-letsencrypt-cron:latest"
  keep_image_locally = true

  volumes = [
    {
      volume_name = "certs"
      host_folder_name = "certs"
      container_path = "/certs/"
    }
  ]
  networks = [module.global_network_gateway.network_name]
}

module "jenkins_global_instance" {
  source = "../modules/environment/"
  env_id = var.env_id
  container_name = "global"
  service_type = "jenkins"
  container_image_name = "jenkins/jenkins:lts-centos"
  keep_image_locally = true
  run_as_privileged = true

  volumes = [
    {
      volume_name = "jenkins_home"
      host_folder_name = "/jenkins_home/"
      container_path = "/var/jenkins_home/"
    }
  ]
  networks = [module.global_network_gateway.network_name]
}

module "nginx_global_instance" {
  source = "../modules/environment/"
  env_id = var.env_id
  container_name = "global"
  service_type = "nginx"
  container_image_name = "nginx:1.17.3"
  keep_image_locally = true
  run_as_privileged = true

  volumes = [
    {
      volume_name = "conf.d"
      host_folder_name = "conf.d"
      container_path = "/etc/nginx/conf.d/"
    }
  ]

  ports = [
    {
      internal = 80
      external = 80
    },
    {
      internal = 443
      external = 443
    }
  ]
  networks = [module.global_network_gateway.network_name]
}