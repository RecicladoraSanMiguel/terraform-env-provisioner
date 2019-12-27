output "container_name" {
  value = module.docker_container.container_name
}

output "depend_link" {
  value = module.docker_container.depend_link
}

output "volumes" {
  value = module.docker_container.volumes
}
