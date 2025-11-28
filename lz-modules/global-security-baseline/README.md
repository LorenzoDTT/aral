# Module to enforce a security baseline in AWS services of all LZ accounts

In this module you can place Terraform resources to apply a security baseline at account level in all LZ accounts.

# Resources created by this module
- `resource "aws_s3_account_public_access_block" "security_baseline"` : Block public S3 access at account level
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_account_public_access_block
https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html