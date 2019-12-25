provider "docker" {
  host = "ssh://${var.docker_host_user}@${var.docker_host_password}:${var.docker_host_port}"
}