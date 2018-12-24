variable "trusting_role_arn" {
  description = "ARN of role to be assumed in trusting account"
  type        = "string"
}

variable "require_mfa" {
  description = "ARNs of accounts, users, or roles who can assume this role"
  type        = "string"
}
