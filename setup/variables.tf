### Required variables ###
variable "global__docker_host_ip" {
  type = string
}

variable "service_name_prefix" {
  type = "string"
  default = "global"
}

### Optional variables ###
variable "setup__base_mountpoint_path" {
  type = "string"
  default = "/share/docker/"
}

variable "setup__networks_list" {
  type = "map"
}
