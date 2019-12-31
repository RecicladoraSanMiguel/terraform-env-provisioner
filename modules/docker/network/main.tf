resource "docker_network" "network" {
  name  = "${var.env_id}-${var.network_suffix}"
  internal = var.internal_only
  attachable = var.is_attachable
  check_duplicate = true
}