data "docker_registry_image" "global_images" {
  name  = var.image_name
  keep_locally = var.discard_image_on_destroy
}
