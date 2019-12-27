output "gateway_network" {
  value = module.global_network_gateway.network_name
}

output "nginx-gateway_vhosts_folder_path" {
  value = module.nginx_global_instance.volumes[0]
}

