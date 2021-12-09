#---------------------------------------------------
# AWS sageMaker model
#---------------------------------------------------
resource "aws_sagemaker_model" "sagemaker_model" {
  name               = "${var.owner}-${var.environment}-${var.sagemaker_model_name}"
  execution_role_arn = aws_iam_role.sagemaker_inference_role.arn

  primary_container {
    image = "${module.{{ cookiecutter.project_slug.replace('-', '_') }}_ecr_repo.repository_url}:${module.{{ cookiecutter.project_slug.replace('-', '_') }}_ecr_repo.tag}"
    model_data_url = "https://s3-us-west-2.amazonaws.com/${aws_s3_bucket.sagemaker_artifacts_bucket.id}/${aws_s3_bucket_object.sagemaker_artifacts_object.id}"
  }

  tags = merge(
    {
      Name = var.sagemaker_model_name
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
      aws_iam_role.sagemaker_inference_role, 
      aws_s3_bucket.sagemaker_artifacts_bucket,
      module.{{ cookiecutter.project_slug.replace('-', '_') }}_ecr_repo
    ]
}