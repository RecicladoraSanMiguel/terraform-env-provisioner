variable "image_name" {
  type = string
}

variable "discard_image_on_destroy" {
  type = bool
  default = false
}

variable "global_docker_images" {
  type = "list"
  default = [
    "henridwyer/docker-letsencrypt-cron:latest",
    "nginx:1.17.3",
    "odoo:8.0",
    "odoo:12.0",
    "postgres:9.4",
    "postgres:10"
  ]
}