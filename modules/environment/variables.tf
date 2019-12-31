variable "env_id" {
  description = ""
  type = string
}

variable "container_name_suffix" {
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

variable "env_vars" {
  description = ""
  type = list(string)
  default = []
}

variable "keep_image_locally" {
  description = ""
  type = bool
  default = false
}

variable "base_env_path" {
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

variable "mounts" {
  description = ""
  type = list(object({
    host_folder_name = string
    container_path = string
  }))
  default = []
}