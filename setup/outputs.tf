output "env_network" {
  value = module.base_env.env_network_name
}

output "nginx-gateway_vhosts_folder_path" {
  value = module.nginx_global_instance.volumes[0]
}
