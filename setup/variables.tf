### Required variables ###
variable "global__docker_host" {
  description = ""
  type = string
  default = "localhost"
}

variable "global__docker_host_user" {
  description = "SSH user to connect to the docker target"
  type = string
}

variable "global__docker_host_password" {
  description = "SSH password to connect to the docker target"
  type = string
}

variable "base_volumes_path" {
  description = ""
  type = string
  default = "/share/docker/containers"
}

variable "env_id" {
  description = "Namespace to wrap around all the service that will be provisioned by terraform"
  type = string
  default = "000"
}

/*
WEBROOT: set this variable to the webroot path if you want to use the webroot plugin. Leave to use the standalone webserver.
DOMAINS: a space separated list of domains for which you want to generate certificates.
EMAIL: where you will receive updates from letsencrypt.
CONCAT: true or false, whether you want to concatenate the certificate's full chain with the private key (required for e.g. haproxy), or keep the two files separate (required for e.g. nginx or apache).
SEPARATE: true or false, whether you want one certificate per domain or one certificate valid for all domains.
*/

variable "certbot_env_vars" {
  description = ""
  type = list(string)
}


