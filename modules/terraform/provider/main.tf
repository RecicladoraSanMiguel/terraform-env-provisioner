module "env_base_config_folder" {
  source = "../../../modules/local/folder"
  path = "${var.env_path}terraform/"
}

module "env_base_state_file" {
  source = "../../../modules/local/file"
  path = module.env_base_config_folder.path_created
  filename = "terraform.tfstate"
  depends = module.env_base_config_folder.to_depend
}

terraform {
  required_version = ">= 0.12.7"

  backend "local" {
    workspace_dir = module.env_base_config_folder.path_created
    path = module.env_base_state_file.file_path
  }
}
