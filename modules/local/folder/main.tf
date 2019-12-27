locals {
  all_mounts = [
    for mount in var.mounts:
      {
        host_folder_name = length(regexall("^(/.*)", mount.host_folder_name)) > 0 ? mount.host_folder_name : "${var.base_volumes_path}/${var.env_id}/${var.service_type}/${mount.host_folder_name}/"
        container_path = mount.container_path
      }
  ]
  to_create_mounts = [
    for mount in var.mounts:
      {
        host_folder_name = length(regexall("^(/.*)", mount.host_folder_name)) > 0 ? "." : "${var.base_volumes_path}/${var.env_id}/${var.service_type}/${mount.host_folder_name}/"
        container_path = mount.container_path
      }
  ]
}

resource "null_resource" "bash" {
  count = length(local.to_create_mounts)
  provisioner "local-exec" {
    command = "mkdir -p ${local.to_create_mounts[count.index].host_folder_name}"
    interpreter = [var.interpreter, "-c"]
  }
}
