variable "vhost_destination_path" {
  description = ""
  type = string
}

variable "vhost_hostname" {
  description = ""
  type = string
  default = "_"
}

variable "vhost_port" {
  description = ""
  type = number
  default = 80
}

variable "upstream" {
  description = ""
  type = object({
    name = string
    port = number
  })
  default = {
    name = "default"
    port: 80
  }
}

