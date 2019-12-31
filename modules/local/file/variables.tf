variable "interpreter" {
  description = ""
  type = string
  default = "/bin/bash"
}

variable "path" {
  description = ""
  type = string
}

variable "filename" {
  description = ""
  type = string
}

variable "depends" {
  description = ""
  type = any
  default = ""
}
