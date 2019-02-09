variable "workspace_iam_roles" {
  type = map
  default = {
    vault       = "arn:aws:iam::VLT-ACCOUNT-ID:role/CodeBuildTerraformExecutionRole"
    development = "arn:aws:iam::DEV-ACCOUNT-ID:role/CodeBuildTerraformExecutionRole"
    production  = "arn:aws:iam::PRD-ACCOUNT-ID:role/CodeBuildTerraformExecutionRole"
    operations  = "arn:aws:iam::OPS-ACCOUNT-ID:role/CodeBuildTerraformExecutionRole"
  }
}

variable "aws_region" {
  description = "AWS region"
}

variable "aws_account_id" {
  description = "The AWS account number"
}

variable "iam_path" {
  description = "Path for IAM resources"
  default = "allcloud"
}

variable "dome9_account_id" {
  description = "The Dome9 AWS account number"
  default = "634729597623"
}

variable "dome9_external_id" {
  description = "The Dome9 external ID"
}