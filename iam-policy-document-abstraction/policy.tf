data "aws_iam_policy_document" "assume_role_policy_mfa" {
  count = var.require_mfa ? 1 : 0

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    resources = compact(flatten([var.trusting_role_arn, var.trusting_role_arns]))

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values = [
        "true"
      ]
    }

  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  count = var.require_mfa ? 0 : 1

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    resources = compact(flatten([var.trusting_role_arn, var.trusting_role_arns]))
  }
}
