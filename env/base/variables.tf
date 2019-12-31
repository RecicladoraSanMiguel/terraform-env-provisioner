variable "env_id" {
  description = ""
  type = string
}

variable "base_volumes_path" {
  description = ""
  type = string
}

variable "host_docker_ssh_user" {
  description = ""
  type = string
}

variable "host_docker_ssh_passwd" {
  description = ""
  type = string
}

### === Optional Values === ###

variable "host_docker_ssh_hostname" {
  description = ""
  type = string
  default = "localhost"
}

variable "host_docker_ssh_port" {
  description = ""
  type = number
  default = 22
}

variable "env_network_suffix" {
  description = ""
  type = string
  default = "-env_ntw"
}

variable "env_network_private" {
  description = ""
  type = bool
  default = true
}

variable "env_network_attachable" {
  description = ""
  type = bool
  default = false
}
