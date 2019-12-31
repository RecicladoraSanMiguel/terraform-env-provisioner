locals {
  file_to_create = "${var.path}${var.filename}"
}

resource "local_file" "file" {
    content     = ""
    filename = local.file_to_create
}
