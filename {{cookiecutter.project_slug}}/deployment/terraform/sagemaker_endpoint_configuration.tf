#---------------------------------------------------
# AWS Sagemaker endpoint configuration
#---------------------------------------------------
resource "aws_sagemaker_endpoint_configuration" "sagemaker_endpoint_configuration" {
  name = "${var.owner}-${var.environment}-${var.sagemaker_endpoint_configuration_name}"
  
  production_variants {

    model_name              = aws_sagemaker_model.sagemaker_model.name
    instance_type           = "ml.t2.medium"
    initial_instance_count  = 1
    initial_variant_weight  = 1

  }

  tags = merge(
    {
      Name = var.sagemaker_endpoint_configuration_name
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_model.sagemaker_model
  ]
}