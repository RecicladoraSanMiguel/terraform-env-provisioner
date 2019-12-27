locals {
  container_name = "${var.env_id}_${var.service_type}_${var.container_name}"
}

resource "docker_container" "docker_container" {
  name = local.container_name
  image = var.image_id
  restart = var.restart_policy
  privileged = var.run_as_privileged
  env = var.env_vars

  dynamic "ports" {
    for_each = [for port in var.ports: {
      internal = port.internal
      external = port.external
    }]
    content {
      internal = ports.value.internal
      external = ports.value.external
    }
  }

  dynamic "mounts" {
    for_each = [for v in var.volumes: {
      container_path = v.container_path
      host_folder_name = v.host_folder_name
    }]
    content {
      type = "bind"
      target = mounts.value.container_path
      source = mounts.value.host_folder_name
    }
  }

  dynamic "networks_advanced" {
    iterator = network
    for_each = var.networks
    content {
      name = network.value
    }
  }
}
