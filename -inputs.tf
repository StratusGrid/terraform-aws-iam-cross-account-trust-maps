variable "trusting_role_arn" {
  description = "ARN of role to be assumed in trusting account - use to map a single assume role trust to a single policy"
  type        = string
  default     = ""
}

variable "trusting_role_arns" {
  description = "ARNs of role to be assumed in trusting account - use to map multiple assume role trusts to a single policy"
  type        = list(string)
  default     = []
}

variable "trusted_policy_name" {
  description = "Name of the policy to be created"
  type        = string
}

variable "trusted_group_names" {
  description = "List of groups to attach policy to"
  type        = list(string)
  default     = []
}

variable "trusted_role_names" {
  description = "list of roles to attach policy to"
  type        = list(string)
  default     = []
}

variable "require_mfa" {
  description = "ARNs of accounts, users, or roles who can assume this role"
  type        = string
}

variable "input_tags" {
  description = "Map of tags to apply to resources"
  type        = map(string)
  default     = {}
}

