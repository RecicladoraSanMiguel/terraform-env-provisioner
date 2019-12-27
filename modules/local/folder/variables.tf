variable "base_volumes_path" {
  description = ""
  type = string
}

variable "env_id" {
  description = ""
  type = string
}

variable "service_type" {
  description = ""
  type = string
}

variable "mounts" {
  description = ""
  type = list(object({
    host_folder_name = string
    container_path = string
  }))
}

variable "interpreter" {
  description = ""
  type = string
  default = "/bin/bash"
}