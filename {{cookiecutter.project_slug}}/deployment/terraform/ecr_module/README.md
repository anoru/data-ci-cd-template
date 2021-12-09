# terraform-aws-ecr-docker-image

Terraform module to build & push a Docker image to an AWS ECR repository.

The image can then be used in an AWS Fargate task.

- Builds from a Dockerfile in the source path
- Pushes to an AWS ECR repository
- Can customize the push and hash scripts
- Cleans up old images from the repository

## Requirements

- Docker
- md5sum (e.g. from `brew install md5sha1sum`)

## Usage

```
module "test" {
  owner        = var.owner
  environment  = var.environment
  applications = var.applications

  tags = var.tags

  source       = "./ecr_module"
  image_name   = "test"
  source_path  = "${path.module}/src"
}
```

## Inputs

| Name        | Description                                        |  Type  |  Default   | Required |
| ----------- | -------------------------------------------------- | :----: | :--------: | :------: |
| hash_script | Path to script to generate hash of source contents | string |    `""`    |    no    |
| image_name  | Name of Docker image                               | string |    n/a     |   yes    |
| push_script | Path to script to build and push Docker image      | string |    `""`    |    no    |
| source_path | Path to Docker image source                        | string |    n/a     |   yes    |
| tag         | Tag to use for deployed Docker image               | string | `"latest"` |    no    |

## Outputs

# Output values are like the return values of a Terraform module.
# In our case we will use it because
# A child module can use outputs to expose a subset of its resource attributes to a parent module.

| Name           | Description                        |
| -------------- | ---------------------------------- |
| hash           | Docker image source hash           |
| repository_url | ECR repository URL of Docker image |
| tag            | Docker image tag                   |
