resource "null_resource" "bash" {
  depends_on = [var.depends]
  provisioner "local-exec" {
    command = "mkdir -p ${var.path}"
    interpreter = [var.interpreter, "-c"]
  }
}
