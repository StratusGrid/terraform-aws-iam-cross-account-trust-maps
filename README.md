<!-- BEGIN_TF_DOCS -->
# terraform-aws-iam-cross-account-trust-maps

GitHub: [StratusGrid/terraform-aws-iam-cross-account-trust-maps](https://github.com/StratusGrid/terraform-aws-iam-cross-account-trust-maps)

Maps assume role rights to trusted account resources for a specific trusting account.

## Example being used for same account role assumption rights mapping:
```hcl
module "iam_group_restricted_admin" {
  source  = "StratusGrid/iam-group-with-user-self-service/aws"
  version = "2.1.0"
  name    = "${var.name_prefix}-restricted-admin${local.full_suffix}"
}

module "iam_cross_account_trust_map_restricted_admin" {
  source              = "StratusGrid/iam-cross-account-trust-maps/aws"
  version             = "2.1.0"
  #source = "github.com/StratusGrid/terraform-aws-iam-cross-account-trust-maps"

  trusting_role_arn   = module.restricted_admin.role_arn
  trusted_policy_name = module.iam_group_restricted_admin.group_name
  trusted_group_names = [
    "${var.name_prefix}-restricted-admin",
  ]

  require_mfa = true
  input_tags  = merge(local.common_tags, {})
}
```
---
## Example Single Trusting ARN Usage:
```hcl
locals {
  trusting_role_arn_other_account = "arn:aws:iam::123456789012:role/cross-account-role-admin"
}

module "iam_cross_account_trust_map" {
  source = "StratusGrid/iam-cross-account-trust-maps/aws"
  version = "2.1.0"

  trusting_role_arn = "${local.trusting_role_arn_other_account}"
  trusted_policy_name = "${replace(local.trusting_role_arn_other_account, "/^([^:]*)+:([^:]*)+:([^:]*)+:([^:]*)+:([^:]*)+:([^/]*)+/([^/]*)$/", "$5-$7")}"
  trusted_group_names = [
    aws_iam_group.mycompany_admins.name
  ]
  trusted_role_names = []
  require_mfa = false
  input_tags = merge(local.common_tags, {})
}
```
---
## Example Multiple Trusting ARN Usage:
#### This should have each terraform state role if you want a user to be able to apply terraform manually
```hcl
locals {
  mycompany_organization_terraform_state_account_roles = [
    "arn:aws:iam::123456789012:role/210987654321-terraform-state",
    "arn:aws:iam::123456789012:role/123456789012-terraform-state"
  ]
}

# When require_mfa is set to true, terraform init and terraform apply would need to be run with your STS acquired temporary token
module "mycompany_organization_terraform_state_trust_maps" {
  source = "StratusGrid/iam-cross-account-trust-maps/aws"
  version = "2.1.0"

  trusting_role_arns = local.mycompany_organization_terraform_state_account_roles
  trusted_policy_name = "mycompany-organization-terraform-states"
  trusted_group_names = [
    aws_iam_group.mycompany_internal_admins.name
  ]
  trusted_role_names = []
  require_mfa = false
  input_tags = merge(local.common_tags, {})
}
```
---

## Resources

| Name | Type |
|------|------|
| [aws_iam_group_policy_attachment.iam_policy_group_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.iam_policy_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_input_tags"></a> [input\_tags](#input\_input\_tags) | Map of tags to apply to resources | `map(string)` | <pre>{<br>  "Developer": "StratusGrid",<br>  "Provisioner": "Terraform"<br>}</pre> | no |
| <a name="input_require_mfa"></a> [require\_mfa](#input\_require\_mfa) | ARNs of accounts, users, or roles who can assume this role | `string` | n/a | yes |
| <a name="input_trusted_group_names"></a> [trusted\_group\_names](#input\_trusted\_group\_names) | List of groups to attach policy to | `list(string)` | `[]` | no |
| <a name="input_trusted_policy_name"></a> [trusted\_policy\_name](#input\_trusted\_policy\_name) | Name of the policy to be created | `string` | n/a | yes |
| <a name="input_trusted_role_names"></a> [trusted\_role\_names](#input\_trusted\_role\_names) | list of roles to attach policy to | `list(string)` | `[]` | no |
| <a name="input_trusting_role_arn"></a> [trusting\_role\_arn](#input\_trusting\_role\_arn) | ARN of role to be assumed in trusting account - use to map a single assume role trust to a single policy | `string` | `""` | no |
| <a name="input_trusting_role_arns"></a> [trusting\_role\_arns](#input\_trusting\_role\_arns) | ARNs of role to be assumed in trusting account - use to map multiple assume role trusts to a single policy | `list(string)` | `[]` | no |

## Outputs

No outputs.

---

<span style="color:red">Note:</span> Manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml .`
<!-- END_TF_DOCS -->