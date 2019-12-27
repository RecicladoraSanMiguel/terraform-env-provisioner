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

module "jenkins_global_instance" {
  source = "../modules/environment/"
  base_volumes_path = "/Users/andrey.castro/Ex_repos/recsm/containers_volumes"
  env_id = var.env_id
  container_name = "global"
  service_type = "jenkins"
  container_image_name = "jenkins/jenkins:lts-centos"
  keep_image_locally = true
  run_as_privileged = true

  mounts = [
    {
      volume_name = "jenkins_home"
      host_folder_name = "jenkins_home"
      container_path = "/var/jenkins_home/"
    }
  ]
  networks = [module.global_network_gateway.network_name]
}

module "certbot_global_instance" {
  source = "../modules/environment/"
  base_volumes_path = "/Users/andrey.castro/Ex_repos/recsm/containers_volumes"
  env_id = var.env_id
  container_name = "global"
  service_type = "certbot"
  container_image_name = "henridwyer/docker-letsencrypt-cron:latest"
  keep_image_locally = true
  env_vars = var.certbot_env_vars

  mounts = [
    {
      host_folder_name = "certs"
      container_path = "/certs/"
    }
  ]

  networks = [module.global_network_gateway.network_name]
}

module "nginx_global_instance" {
  source = "../modules/environment/"
  base_volumes_path = "/Users/andrey.castro/Ex_repos/recsm/containers_volumes"
  env_id = var.env_id
  container_name = "global"
  service_type = "nginx"
  container_image_name = "nginx:1.17.3"
  keep_image_locally = true
  run_as_privileged = true

  mounts = [
    {
      host_folder_name = "conf.d"
      container_path = "/etc/nginx/conf.d/"
    },
    {
      host_folder_name = module.certbot_global_instance.volumes[0]
      container_path = "/certs/"
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

module "certbot_vhost" {
  source = "../modules/nginx_vhosts/certbot"
  vhost_hostname = "_"
  vhost_port = 80
  upstream = {
    name = module.certbot_global_instance.container_name
    service_type = "cerbot"
    port: 80
  }
  vhost_destination_path = module.nginx_global_instance.volumes[0]
}

module "jenkins_vhost" {
  source = "../modules/nginx_vhosts/proxy"
  vhost_hostname = "jenkins.recsm.com"
  is_secure = false
  upstream = {
    name = module.jenkins_global_instance.container_name
    service_type = "jenkins"
    port: 8080
  }
  vhost_destination_path = module.nginx_global_instance.volumes[0]
}

//module "certbot_exec" {
//  source = "../modules/local/container_exec"
//  module_depends_on = [module.certbot_global_instance.depend_link]
//  container_name = module.certbot_global_instance.container_name
//  bash_command = "/scripts/run_certbot.sh"
//  interpreter = "ash"
//}

//module "nginx_reload" {
//  source = "../modules/local/container_exec"
//  module_depends_on = [module.nginx_global_instance.depend_link]
//  container_name = module.nginx_global_instance.container_name
//  bash_command = "service nginx restart"
//}
