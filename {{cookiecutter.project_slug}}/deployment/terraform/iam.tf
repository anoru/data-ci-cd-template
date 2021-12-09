# Assume sagemaker role
data "aws_iam_policy_document" "sagemaker_assume_role" {
  statement {
    actions = [ "sts:AssumeRole" ]
    principals {
      type = "Service"
      identifiers = [ "sagemaker.amazonaws.com" ]
    }
  }
}

resource "aws_iam_role" "sagemaker_inference_role" {
  name = "${var.owner}-${var.environment}-sagemaker-role"
  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role.json

  tags = var.tags
}

# IAM pollicy granting
# SageMaker full access
# Cloudwatch put metrics and create log group access
# ECR authorisation to use the image
# S3 access to get objects in the project bucket
data "aws_iam_policy_document" "sagemaker_inference_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:*"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:CreateLogGroup",
      "logs:DescribeLogStreams",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = [
      "*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.sagemaker_artifacts_bucket.id}",
      "arn:aws:s3:::${aws_s3_bucket.sagemaker_artifacts_bucket.id}/*"
    ]
  }
}

resource "aws_iam_policy" "sagemaker_inference_policy" {
  name = "${var.owner}-${var.environment}-sagemaker-inferance-policy"
  description = "Allow Sagemaker to create models"
  policy = data.aws_iam_policy_document.sagemaker_inference_policy.json

  tags = var.tags
}

# Attach the role to the policy
resource "aws_iam_role_policy_attachment" "sagemake_inference" {
  role = aws_iam_role.sagemaker_inference_role.name
  policy_arn = aws_iam_policy.sagemaker_inference_policy.arn
}