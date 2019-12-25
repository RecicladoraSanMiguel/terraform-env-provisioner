resource "docker_network" "network" {
  name  = var.network_name
  internal = var.internal_only
  attachable = var.is_attachable
  check_duplicate = true
}