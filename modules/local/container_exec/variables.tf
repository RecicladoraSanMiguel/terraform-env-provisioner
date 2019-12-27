variable "container_name" {
  description = ""
  type = string
}

variable "bash_command" {
  description = ""
  type = string
}

variable "interpreter" {
  description = ""
  type = string
  default = ""
}

variable "module_depends_on" {
  description = ""
  type = any
  default = [""]
}
