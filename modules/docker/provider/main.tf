provider "docker" {
  host = "tcp://${var.docker_host_ip}:2376/"
}