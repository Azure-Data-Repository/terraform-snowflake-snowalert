module "geff_snowalert" {
  count  = length(var.handlers) > 0 ? 1 : 0
  source = "git::https://github.com/Snowflake-Labs/terraform-snowflake-api-integration-with-geff-aws.git?ref=v0.3.6"

  # Required
  prefix = var.prefix
  env    = var.env

  # Snowflake
  snowflake_integration_user_roles = var.snowflake_integration_user_roles

  # AWS
  aws_region = local.aws_region
  arn_format = var.arn_format

  # Other config items
  geff_image_version = var.geff_image_version
  data_bucket_arns   = var.data_bucket_arns
  geff_secret_arns   = local.snowalert_secret_arns

  providers = {
    snowflake.api_integration_role     = snowflake.security_api_integration_role
    snowflake.storage_integration_role = snowflake.security_storage_integration_role
    aws                                = aws
  }
}
