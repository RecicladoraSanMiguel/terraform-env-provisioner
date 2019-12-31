output "path_created" {
  value = var.path
}

output "to_depend" {
  value = null_resource.bash.id
}
