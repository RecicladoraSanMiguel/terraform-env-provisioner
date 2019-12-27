variable "env_id" {
  description = ""
  type = string
}

variable "base_volumes_path" {
  description = ""
  type = string
}

variable "container_name" {
  description = ""
  type = string
}

variable "image_id" {
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
  default = true
}

variable "run_as_privileged" {
  description = ""
  type = bool
  default = false
}

variable "restart_policy" {
  description = ""
  type = string
  default = "unless-stopped"
}

variable "service_type" {
  description = ""
  type = string
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
    host_folder_name = string
    container_path = string
  }))
  default = []
}

