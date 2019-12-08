variable "network_name" {
  type = string
}

variable "internal_only" {
  type = bool
  default = true
}

variable "is_attachable" {
  type = bool
  default = false
}