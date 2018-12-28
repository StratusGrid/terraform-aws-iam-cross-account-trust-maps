data "aws_iam_policy_document" "assume_role_policy_mfa" {
  count = "${var.require_mfa}"
  
  statement {
    effect = "Allow"

    actions   = [
      "sts:AssumeRole"
    ]

    resources = [
      "${split(",", coalesce(var.trusting_role_arn, join(",", var.trusting_role_arns)))}"
    ]

     condition {
      test = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values = [
        "true"
      ]
    }
    
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  count = "${1 - var.require_mfa}"

  statement {
    effect = "Allow"

    actions   = [
      "sts:AssumeRole"
    ]

    resources = [
      "${split(",", coalesce(var.trusting_role_arn, join(",", var.trusting_role_arns)))}"
    ]
  }
}
