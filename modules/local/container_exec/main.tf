resource "null_resource" "module_depends_on" {
  triggers = {
    value = "${length(var.module_depends_on)}"
  }
}

resource "null_resource" "bash" {
  depends_on = [null_resource.module_depends_on]
  provisioner "local-exec" {
    command = "docker exec ${var.container_name} ${var.interpreter} ${var.bash_command}"
    interpreter = ["/bin/bash", "-c"]
  }
}
