variable "docker_host_user" {
  description = "SSH User to connect to the docker host"
  type = string
}

variable "docker_host_password" {
  description = "SSH Password to connect to the docker host"
  type =  string
}

#-----------------------------------#
#------- OPTIONAL VALUES: ----------#
#-----------------------------------#

variable "docker_host" {
  description = "Hostname where the containers will be provisioned"
  type = string
  default = "localhost"
}

variable "docker_host_port" {
  description = "Port to coneect via ssh to the host"
  type =  number
  default = 22
}
