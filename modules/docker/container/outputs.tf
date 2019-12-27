output "container_name" {
  value = local.container_name
}

output "depend_link" {
  value = docker_container.docker_container.bridge
}

output "volumes" {
  value = [
    for volume in var.volumes:
      volume.host_folder_name
  ]
}
