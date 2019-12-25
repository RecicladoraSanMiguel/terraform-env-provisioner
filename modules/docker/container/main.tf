resource "docker_container" "docker_container" {
  name = "${var.env_id}-${var.service_type}-${var.container_name}"
  image = var.image_id
  restart = var.restart_policy
  privileged = var.run_as_privileged

  dynamic "ports" {
    for_each = [for p in var.ports: {
      internal = p.internal
      external = p.external
    }]
    content {
      internal = ports.value.internal
      external = ports.value.external
    }
  }

  dynamic "volumes" {
    for_each = [for v in var.volumes: {
      volume_name = v.volume_name
      host_folder_name = v.host_folder_name
      container_path = v.container_path
    }]
    content {
      volume_name = "${var.env_id}-${var.service_type}-${volumes.value.volume_name}"
      host_path = "${var.base_volumes_path}/${var.env_id}}/${var.service_type}/${volumes.value.host_folder_name}/"
      container_path = volumes.value.container_path
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
