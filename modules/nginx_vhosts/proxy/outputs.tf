output "vhost_file" {
  value = data.template_file.proxy.rendered
}