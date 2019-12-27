//variable "upstream" {
//  description = ""
//  type = object({
//    service_type = string
//    port = number
//    extra_configs = string
//  })
//}
//
//variable "certificate_file_name" {
//  description = ""
//  type = string
//  default = ""
//}
//
//variable "certicates_folder_path" {
//  description = ""
//  type = string
//  default = ""
//}
//
//variable "vhost_destination_path" {
//  description = ""
//  type = string
//}
//
//variable "vhost_hostname" {
//  description = ""
//  type = string
//}
//
//variable "vhost_port" {
//  description = ""
//  type = number
//  default = 443
//}

variable "vhost_destination_path" {
  description = ""
  type = string
}

variable "vhost_hostname" {
  description = ""
  type = string
}

variable "vhost_extra_configs" {
  description = ""
  type = string
  default = ""
}

variable "is_secure" {
  description = ""
  type = bool
  default = true
}

variable "upstream" {
  description = ""
  type = object({
    name = string
    port = number
  })
}

