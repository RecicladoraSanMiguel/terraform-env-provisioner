data "template_file" "proxy" {
  template = "${file("${path.module}/../templates/proxy_vhost.tpl")}"
    vars = {
    vhost_hostname = var.vhost_hostname
    vhost_port = var.is_secure == true ? 443 : 80
    upstream_name = var.upstream.name
    upstream_port = var.upstream.port
    upstream_extra_configs = var.vhost_extra_configs
  }
}

resource "local_file" "vhost" {
  filename = "${var.vhost_destination_path}${var.upstream.name}_${var.vhost_hostname}_http.conf"
  content = data.template_file.proxy.rendered
}