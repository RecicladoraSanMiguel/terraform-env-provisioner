module "base_env" {
  source = "../env/base"
  base_volumes_path = var.base_volumes_path
  env_id = "000"
  host_docker_ssh_user = var.global__docker_host_user
  host_docker_ssh_passwd = var.global__docker_host_password
  env_network_suffix = "gateway"
  env_network_private = false
  env_network_attachable = true
}

module "jenkins_global_instance" {
  source = "../modules/environment/"
  base_env_path = module.base_env.env_path
  env_id = module.base_env.env_id
  container_name_suffix = "global"
  service_type = "jenkins"
  container_image_name = "jenkins/jenkins:lts-centos"
  keep_image_locally = true
  run_as_privileged = true

  mounts = [
    {
      host_folder_name = "jenkins_home"
      container_path = "/var/jenkins_home/"
    }
  ]
  networks = [module.base_env.env_network_name]
}

module "certbot_global_instance" {
  source = "../modules/environment/"
  base_env_path = module.base_env.env_path
  env_id = module.base_env.env_id
  container_name_suffix = "global"
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

  networks = [module.base_env.env_network_name]
}

module "nginx_global_instance" {
  source = "../modules/environment/"
  base_env_path = module.base_env.env_path
  env_id = module.base_env.env_id
  container_name_suffix = "global"
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

  networks = [module.base_env.env_network_name]
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
