variable "global__docker_host_user" {
  description = "SSH user to connect to the docker target"
  type = string
}

variable "global__docker_host_password" {
  description = "SSH password to connect to the docker target"
  type = string
}

variable "env_id" {
  description = "Namespace to wrap around all the service that will be provisioned by terraform"
  type = string
}

variable "is_dev" {
  description = ""
  type = bool
  default = false
}

variable "global__docker_host" {
  description = ""
  type = string
  default = "localhost"
}

variable "global__docker_host_port" {
  description = ""
  type = number
  default = 22
}

variable "base_volumes_path" {
  description = ""
  type = string
  default = "/share/docker/containers"
}

variable "db_name" {
  description = ""
  type = string
  default = "postgres"
}

variable "db_user" {
  description = ""
  type = string
  default = "odoo"
}

variable "db_password" {
  description = ""
  type = string
  default = "odoo"
}