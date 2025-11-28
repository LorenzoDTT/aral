# Terraform Module for AWS Control Tower Controls (sometimes called Guardrails)

Control Tower has a Security Controls library on which you can enforce preventive and detective controls

https://docs.aws.amazon.com/controltower/latest/userguide/controls-reference.html

Controls are implemented by Control Tower by the use of Guardrails

While setting up the Landing Zone with Control Tower, the service enables some of them automatically since they are considered mandatory.

https://docs.aws.amazon.com/controltower/latest/userguide/mandatory-controls.html


# List of available guardrails

List of Control Tower Controls https://docs.aws.amazon.com/controltower/latest/userguide/controltower-ug.pdf

# Designations for Elective controls
- AWS-GR_AUDIT_BUCKET_ENCRYPTION_ENABLED
- AWS-GR_AUDIT_BUCKET_LOGGING_ENABLED
- AWS-GR_AUDIT_BUCKET_POLICY_CHANGES_PROHIBITED
- AWS-GR_AUDIT_BUCKET_RETENTION_POLICY
- AWS-GR_IAM_USER_MFA_ENABLED
- AWS-GR_MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS
- AWS-GR_RESTRICT_S3_CROSS_REGION_REPLICATION
- AWS-GR_RESTRICT_S3_DELETE_WITHOUT_MFA
- AWS-GR_S3_VERSIONING_ENABLED

# Designations for Data residency controls (elective)
- AWS-GR_SUBNET_AUTO_ASSIGN_PUBLIC_IP_DISABLED
- AWS-GR_AUTOSCALING_LAUNCH_CONFIG_PUBLIC_IP_DISABLED
- AWS-GR_DISALLOW_CROSS_REGION_NETWORKING
- AWS-GR_DISALLOW_VPC_INTERNET_ACCESS
- AWS-GR_DISALLOW_VPN_CONNECTIONS
- AWS-GR_DMS_REPLICATION_NOT_PUBLIC
- AWS-GR_EBS_SNAPSHOT_PUBLIC_RESTORABLE_CHECK
- AWS-GR_EC2_INSTANCE_NO_PUBLIC_IP
- AWS-GR_EKS_ENDPOINT_NO_PUBLIC_ACCESS
- AWS-GR_ELASTICSEARCH_IN_VPC_ONLY
- AWS-GR_EMR_MASTER_NO_PUBLIC_IP
- AWS-GR_LAMBDA_FUNCTION_PUBLIC_ACCESS_PROHIBITED
- AWS-GR_NO_UNRESTRICTED_ROUTE_TO_IGW
- AWS-GR_REDSHIFT_CLUSTER_PUBLIC_ACCESS_CHECK
- AWS-GR_S3_ACCOUNT_LEVEL_PUBLIC_ACCESS_BLOCKS_PERIODIC
- AWS-GR_SAGEMAKER_NOTEBOOK_NO_DIRECT_INTERNET_ACCESS
- AWS-GR_SSM_DOCUMENT_NOT_PUBLIC

# Designations for Strongly recommended controls
- AWS-GR_ENCRYPTED_VOLUMES
- AWS-GR_EBS_OPTIMIZED_INSTANCE
- AWS-GR_EC2_VOLUME_INUSE_CHECK
- AWS-GR_RDS_INSTANCE_PUBLIC_ACCESS_CHECK
- AWS-GR_RDS_SNAPSHOTS_PUBLIC_PROHIBITED
- AWS-GR_RDS_STORAGE_ENCRYPTED
- AWS-GR_RESTRICTED_COMMON_PORTS
- AWS-GR_RESTRICTED_SSH
- AWS-GR_RESTRICT_ROOT_USER
- AWS-GR_RESTRICT_ROOT_USER_ACCESS_KEYS
- AWS-GR_ROOT_ACCOUNT_MFA_ENABLED
- AWS-GR_S3_BUCKET_PUBLIC_READ_PROHIBITED
- AWS-GR_S3_BUCKET_PUBLIC_WRITE_PROHIBITED


# Setup

This module needs some input variables to perform the control implementation:
* `the control ID` to be implemented
* `the OU ID` on which the control must be implemented

Since controls are enforced in the LZ management account by the use of AWS Control Tower, these input values are included in `lz-management-account\variables.tf`

First check with Infrastructure and Security team to decide at what level do you need to enforce the control (i.e. what are the OUs that need to be included on each list).

```
ct_controls = [
    {
        control_names = [
            "AWS-GR_ENCRYPTED_VOLUMES",
            ...
        ],
        organizational_unit_ids = ["<Organizational Unit Id>"],
    },
    {
        control_names = [
            "AWS-GR_SUBNET_AUTO_ASSIGN_PUBLIC_IP_DISABLED",
            ...
        ],
        organizational_unit_ids = ["<Organizational Unit Id>"],
    },
]
```
The organizational unit ids should follow the pattern `^ou-[0-9a-z]{4,32}-[a-z0-9]{8,32}$`, for example, `ou-1111-11111111`.


## Usage

The module needs to be deployed in the management account `lz-management-account\main.tf`

```
module "controltower_controls" {
  source                = "github.com/LorenzoDTT/aral/management-ct-controls"
  controls              = var.ct_controls
}
```
Since it deployes controls that can be preventive (i.e. SCP) and detective (i.e. AWS Config rules), it is deployed independently from SCP module.
Use SCP module to create custom SCPs since Control Tower deployes automatically SCP (you cannot edit them to include specific conditions)


At this point you can initialize Terraform in this LZ account repository
```
$ terraform init -upgrade
```
visualize the changes

```
$ terraform plan 
```
and deploy the resources
```
$ terraform apply 
```

If you encounter the following error, you will need to disable the control in the console and then apply it with this Terraform automation since the root cause is that the control has been enabled in the console before applying this Terraform code.

```
│ Error: creating ControlTower Control (arn:aws:organizations::638668766210:ou/o-ml3z45ghlp/ou-7d8z-0pcon0gn,arn:aws:controltower:eu-central-1::control/AWS-GR_RESTRICT_ROOT_USER): ValidationException: Guardrail AWS-GR_RESTRICT_ROOT_USER is already enabled on organizational unit ou-7d8z-0pcon0gn
│ 
│   with module.control_tower_controls.aws_controltower_control.guardrails["arn:aws:controltower:eu-central-1::control/AWS-GR_RESTRICT_ROOT_USER:ou-7d8z-0pcon0gn"],
│   on .terraform/modules/control_tower_controls/management_ct_controls/main.tf line 8, in resource "aws_controltower_control" "guardrails":
│    8: resource "aws_controltower_control" "guardrails" {
```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.45.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_controltower_control.guardrails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/controltower_control) | resource |
| [aws_organizations_organization.organization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_organizations_organizational_units.ous_depth_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organizational_units) | data source |
| [aws_organizations_organizational_units.ous_depth_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organizational_units) | data source |
| [aws_organizations_organizational_units.ous_depth_3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organizational_units) | data source |
| [aws_organizations_organizational_units.ous_depth_4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organizational_units) | data source |
| [aws_organizations_organizational_units.root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organizational_units) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_controls"></a> [controls](#input\_controls) | Configuration of AWS Control Tower Guardrails for the whole organization | <pre>list(object({<br>    control_names           = list(string)<br>    organizational_unit_ids = list(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ous_id_to_arn_map"></a> [ous\_id\_to\_arn\_map](#output\_ous\_id\_to\_arn\_map) | Map from OU id to OU arn for the whole organization |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Additional Information

Please note that rarely when updating existing resources `terraform apply` might fail and should be rerun.