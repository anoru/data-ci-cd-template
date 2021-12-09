# Create an s3 bucket for the artifacts
resource "aws_s3_bucket" "sagemaker_artifacts_bucket" {
  bucket = "${var.owner}-${var.environment}-${var.sagemaker_artifacts_bucket_name}-${tostring(random_string.id_generator.id)}-${data.aws_region.current.name}"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }

  tags = var.tags
}

resource "aws_s3_bucket_object" "sagemaker_artifacts_object" {
  bucket = aws_s3_bucket.sagemaker_artifacts_bucket.bucket
  key    = "test/model/model.tar.gz"
  source = "../../{{ cookiecutter.project_slug.replace('-', '_') }}/models/model.tar.gz"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = "${filemd5("../../{{ cookiecutter.project_slug.replace('-', '_') }}/models/model.tar.gz")}"
}