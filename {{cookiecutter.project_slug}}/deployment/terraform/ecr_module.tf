module "{{ cookiecutter.project_slug.replace('-', '_') }}_ecr_repo" {
  owner        = var.owner
  environment  = var.environment
  applications = var.applications

  tags = var.tags

  source       = "./ecr_module"
  image_name   = "{{ cookiecutter.project_slug }}"
  source_path  = "../../${path.module}"
}