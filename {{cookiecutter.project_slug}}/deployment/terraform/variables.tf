#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-3"
}
variable "owner" {
  description = "Name to be used on all resources as prefix"
  type        = string
  default     = "lab"
}

variable "environment" {
  description = "Environment for service"
  type        = string
  default     = "dev"
}

variable "applications" {
  description = "the name of the application"
  type        = string
  default     = ""
}
variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#-----------------------------------------------------------
# SageMaker vars
#-----------------------------------------------------------
variable "sagemaker_artifacts_bucket_name" {
  description = "The name of sagemaker artifacts bucket"
  type        = string
  default     = ""
}
variable "sagemaker_model_package_group_name" {
  description = "The name of the model group."
  type        = string
  default     = ""
}

variable "sagemaker_model_package_group_description" {
  description = "The description of the model group"
  type        = string
  default     = null
}

variable "sagemaker_model_name" {
  description = "The model name"
  type        = string
  default     = ""
}

variable "{{ cookiecutter.project_slug.replace('-', '_') }}_repo" {
  description = "The name of the ecr repo"
  type        = string
  default     = ""
}

variable "docker_image_name" {
  description = "The docker image name in ECR"
  type        = string
  default     = ""
}

variable "sagemaker_endpoint_configuration_name" {
  description = "The sageMaker endpoint configuration name"
  type        = string
  default     = ""

}

variable "sagemaker_endpoint_name" {
  description = "The sageMaker endpoint name"
  type        = string
  default     = ""

}