variable "env_id" {
  description = ""
  type = string
}

variable "network_name" {
  description = ""
  type = string
  default = "default"
}

variable "internal_only" {
  description = ""
  type = bool
  default = true
}

variable "is_attachable" {
  description = ""
  type = bool
  default = false
}
