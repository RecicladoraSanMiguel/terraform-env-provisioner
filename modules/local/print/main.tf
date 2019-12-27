resource "null_resource" "bash" {
  provisioner "local-exec" {
    command = "echo ${var.string_to_print}"
    interpreter = [var.interpreter, "-c"]
  }
}
