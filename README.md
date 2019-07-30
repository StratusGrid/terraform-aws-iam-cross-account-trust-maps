# terraform-aws-iam-cross-account-trust-maps
Maps assume role rights to trusted account resources for specific trusting role or multiple trusting roles


## Example being used for same account role assumption rights mapping:
```
module "iam_group_restricted_admin" {
  source  = "StratusGrid/iam-group-with-user-self-service/aws"
  version = "1.0.0"
  name    = "${var.name_prefix}-restricted-admin${local.full_suffix}"
}

module "iam_cross_account_trust_map_restricted_admin" {
  #source              = "StratusGrid/iam-cross-account-trust-maps/aws"
  #version             = "1.1.0"
  source = "github.com/StratusGrid/terraform-aws-iam-cross-account-trust-maps?ref=tf12"

  trusting_role_arn   = module.restricted_admin.role_arn
  trusted_policy_name = module.iam_group_restricted_admin.group_name
  trusted_group_names = [
    "${var.name_prefix}-restricted-admin",
  ]

  require_mfa = true
  input_tags  = merge(local.common_tags, {})
}
```

## Example Single Trusting ARN Usage:
```
locals {
  trusting_role_arn_other_account = "arn:aws:iam::123456789012:role/cross-account-role-admin"
}

module "iam_cross_account_trust_map" {
  source = "StratusGrid/iam-cross-account-trust-maps/aws"
  version = "2.0.0"
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

## Example Multiple Trusting ARN Usage:
```
# This should have each terraform state role if you want a user to be able to apply terraform manually
locals {
  mycompany_organization_terraform_state_account_roles = [
    "arn:aws:iam::123456789012:role/210987654321-terraform-state",
    "arn:aws:iam::123456789012:role/123456789012-terraform-state"
  ]
}

# When require_mfa is set to true, terraform init and terraform apply would need to be run with your STS acquired temporary token
module "mycompany_organization_terraform_state_trust_maps" {
  source = "StratusGrid/iam-role-cross-account-trusting/aws"
  version = "2.0.0"
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
