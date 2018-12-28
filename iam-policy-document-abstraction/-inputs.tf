variable "trusting_role_arn" {
  description = "ARN of role to be assumed in trusting account - use to map a single assume role trust to a single policy"
  type        = "string"
}

variable "trusting_role_arns" {
  description = "ARNs of role to be assumed in trusting account - use to map multiple assume role trusts to a single policy"
  type        = "list"
}

variable "require_mfa" {
  description = "ARNs of accounts, users, or roles who can assume this role"
  type        = "string"
}
