output "file_path" {
  value = local.file_to_create
}

output "to_depend" {
  value = local_file.file.id
}
