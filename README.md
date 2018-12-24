# terraform-aws-iam-cross-account-trust-maps
Maps assume role rights to trusted account resources for specific trusting account


## Example Usage:
```
module "iam_cross_account_trust_map" {
  source = "StratusGrid/iam-cross-account-trust-maps/aws"
  version = "1.0.0"
  trusting_role_arn = "arn:aws:iam::123456789012:role/cross-account-role-admin"
  trusted_policy_name = "${replace("arn:aws:iam::123456789012:role/cross-account-role-admin", "/^([^:]*)+:([^:]*)+:([^:]*)+:([^:]*)+:([^:]*)+:([^/]*)+/([^/]*)$/", "$5-$7")}"
  trusted_group_names = []
  trusted_role_names = []
  require_mfa = false  
  input_tags = "${local.common_tags}"
}
```
