#---------------------------------------------------
# AWS sagemaker model package group
#---------------------------------------------------
resource "aws_sagemaker_model_package_group" "sagemaker_model_package_group" {

  model_package_group_name = "${var.owner}-${var.environment}-${var.sagemaker_model_package_group_name}"
  model_package_group_description = var.sagemaker_model_package_group_description

  tags = merge(
    {
      Name = var.sagemaker_model_package_group_name
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}