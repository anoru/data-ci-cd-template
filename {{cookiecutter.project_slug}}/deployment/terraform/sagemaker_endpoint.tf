#---------------------------------------------------
# AWS Sagemaker endpoint
#---------------------------------------------------
resource "aws_sagemaker_endpoint" "sagemaker_endpoint" {

  name                 = "${var.owner}-${var.environment}-${var.sagemaker_endpoint_name}"
  endpoint_config_name = aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration.name

  tags = merge(
    {
      Name = var.sagemaker_endpoint_name
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration
  ]
}