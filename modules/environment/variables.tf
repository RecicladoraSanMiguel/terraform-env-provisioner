variable "env_id" {
  description = ""
  type = string
}

variable "container_name" {
  description = ""
  type = string
}

variable "container_image_name" {
  description = ""
  type = string
}

variable "service_type" {
  description = ""
  type = string
}

variable "keep_image_locally" {
  description = ""
  type = bool
  default = false
}

variable "base_volumes_path" {
  description = ""
  type = string
  default = "/share/docker/containers"
}

variable "run_as_privileged" {
  description = ""
  type = bool
  default = false
}

variable "networks" {
  description = ""
  type = list(string)
  default = ["default"]
}

variable "ports" {
  description = ""
  type = list(object({
    internal = number
    external = number
  }))
  default = []
}

variable "volumes" {
  description = ""
  type = list(object({
    volume_name = string
    host_folder_name = string
    container_path = string
  }))
  default = []
}