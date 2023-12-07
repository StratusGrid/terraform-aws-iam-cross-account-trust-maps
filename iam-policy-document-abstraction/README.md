<!-- BEGIN_TF_DOCS -->

# This is used to return a single document with the appropriate MFA choice
---

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_require_mfa"></a> [require\_mfa](#input\_require\_mfa) | ARNs of accounts, users, or roles who can assume this role | `string` | n/a | yes |
| <a name="input_trusting_role_arn"></a> [trusting\_role\_arn](#input\_trusting\_role\_arn) | ARN of role to be assumed in trusting account - use to map a single assume role trust to a single policy | `string` | n/a | yes |
| <a name="input_trusting_role_arns"></a> [trusting\_role\_arns](#input\_trusting\_role\_arns) | ARNs of role to be assumed in trusting account - use to map multiple assume role trusts to a single policy | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_policy_json"></a> [iam\_policy\_json](#output\_iam\_policy\_json) | Outputs the iam policy in json format |

---
<!-- END_TF_DOCS -->