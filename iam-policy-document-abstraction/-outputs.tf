output "iam_policy_json" {
  description = "Outputs the iam policy in json format"
  value       = join(",", concat(data.aws_iam_policy_document.assume_role_policy[*].json, data.aws_iam_policy_document.assume_role_policy_mfa[*].json))
}
