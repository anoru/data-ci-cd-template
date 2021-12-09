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
  default     = "app"
}
variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}


variable "image_name" {
  description = "Name of Docker image"
  type        = string
}

variable "source_path" {
  description = "Path to Docker image source"
  type        = string
}

variable "tag" {
  description = "Tag to use for deployed Docker image"
  type        = string
  default     = "latest"
}

variable "hash_script" {
  description = "Path to script to generate hash of source contents"
  type        = string
  default     = ""
}

variable "push_script" {
  description = "Path to script to build and push Docker image"
  type        = string
  default     = ""
}