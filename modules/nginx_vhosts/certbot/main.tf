data "template_file" "proxy" {
  template = file("${path.module}/../templates/certbot.tpl")
  vars = {
    hostname = var.vhost_hostname
    port = var.vhost_port
    upstream_name = var.upstream.name
    upstream_port = var.upstream.port
  }
}

resource "local_file" "vhost" {
  filename = "${var.vhost_destination_path}${var.upstream.name}_${var.vhost_hostname}_http.conf"
  content = data.template_file.proxy.rendered
}