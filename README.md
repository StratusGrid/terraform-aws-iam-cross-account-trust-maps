# terraform-aws-iam-cross-account-trust-maps
Maps assume role rights to trusted account resources for specific trusting account


## Example Usage:
```
locals {
  trusting_role_arn_other_account = "arn:aws:iam::123456789012:role/cross-account-role-admin"
}

module "iam_cross_account_trust_map" {
  source = "StratusGrid/iam-cross-account-trust-maps/aws"
  version = "1.0.0"
  trusting_role_arn = "${local.trusting_role_arn_other_account}"
  trusted_policy_name = "${replace(local.trusting_role_arn_other_account, "/^([^:]*)+:([^:]*)+:([^:]*)+:([^:]*)+:([^:]*)+:([^/]*)+/([^/]*)$/", "$5-$7")}"
  trusted_group_names = [
    "${aws_iam_group.mycompany_admins.name}"
  ]
  trusted_role_names = []
  require_mfa = false  
  input_tags = "${local.common_tags}"
}
```
