### Required variables ###
variable "global__docker_host" {
  description = ""
  type = string
  default = "localhost"
}

variable "global__docker_host_user" {
  description = "SSH user to connect to the docker target"
  type = string
}

variable "global__docker_host_password" {
  description = "SSH password to connect to the docker target"
  type = string
}

variable "base_volumes_path" {
  description = ""
  type = string
  default = "/share/docker/containers"
}

variable "env_id" {
  description = "Namespace to wrap around all the service that will be provisioned by terraform"
  type = string
  default = "000"
}