# terraform-aws-sagemaker-inference

Terraform code to build & push a Docker image to an AWS ECR repository
and deploy the infrastructure for the inference part in sagemaker.

0. define needed environment variables [variables.tf](variables.tf )
1. Deploy an S3 bucket with an object that point to the model artifact [s3.tf](s3.tf)
2. Deploy an ECR repo using a terraform ecr module (see [ecr_module](ecr_module/README.md) and [ecr.tf](ecr.tf) )
3. Deploy an IAM role to grant the needed access [iam.tf](iam.tf)
4. Deploy a sageMaker model [sagemaker_model.tf](sagemaker_model.tf) referencing the image deployed in step 2
5. Deploy a sageMaker endpoint configuration [sagemaker_endpoint_configuration.tf](sagemaker_endpoint_configuration.tf) referencing the model created in step 4
6. Deploy a sageMaker endpoint [sagemaker_endpoint.tf](sagemaker_endpoint.tf) referencing the configuration created in step 5

## Requirements

- Docker
- md5sum (e.g. from `brew install md5sha1sum`)

## Variables

| Name                                      | Description                                                                | Type           | Default   | Required |
|-------------------------------------------|----------------------------------------------------------------------------|----------------|-----------|----------|
| region                                    | AWS region to deploy your configuration                                    | string         | eu-west-3 | Yes      |
| owner                                     | Name to be used on all resources as prefix                                 | string         | lab       | Yes      |
| environment                               | Environment for service                                                    | string         | dev       | Yes      |
| applications                              | The name of the app/project                                                | string         | ""        | No       |
| tags                                      | A list of tag blocks. Each element should have keys named key, value, etc. | map ( string ) | {}        | Yes      |
| sagemaker_artifacts_bucket_name           | The name of sagemaker artifacts bucket                                     | string         | ""        | Yes      |
| sagemaker_model_package_group_name        | The name of the model group                                                | string         | ""        | Yes      |
| sagemaker_model_package_group_description | The description of the model group                                         | string         | ""        | No       |
| sagemaker_model_name                      | The model name                                                             | string         | ""        | Yes      |
| {{ cookiecutter.project_slug.replace('-', '_') }}_repo | The name of the ecr repo                                                   | string         | ""        | Yes      |
| docker_image_name                         | The docker image name in ECR                                               | string         | ""        | Yes      |
| sagemaker_endpoint_configuration_name     | The sageMaker endpoint configuration name                                  | string         | ""        | Yes      |
| sagemaker_endpoint_name                   | The sageMaker endpoint name                                                | string         | ""        | Yes      |

## Usage

Create a `terrafom.tfvars` file that has the variables values before `terraform apply`

```
region = "eu-west-3"
environment = "dev"
applications = "{{ cookiecutter.project_slug }}"

tags = {
    owner: "lab",
    environment: "dev",
    applications: "{{ cookiecutter.project_slug }}",
    terraform: "true"
}

sagemaker_artifacts_bucket_name = "sagemaker-artifacts"
sagemaker_model_package_group_name = "{{ cookiecutter.project_slug }}-model-package-group"
sagemaker_model_package_group_description = "{{ cookiecutter.project_description }}"
sagemaker_model_name = "{{ cookiecutter.project_slug }}-model"
{{ cookiecutter.project_slug.replace('-', '_') }}_repo = "{{ cookiecutter.project_slug }}"
docker_image_name = "{{ cookiecutter.project_slug }}"
sagemaker_endpoint_configuration_name = "{{ cookiecutter.project_slug }}-endpoint-conf"
sagemaker_endpoint_name = "{{ cookiecutter.project_slug }}-endpoint"
```