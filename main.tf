module "iam_policy_document" {
  source = "./iam-policy-document-abstraction"
  trusting_role_arn = "${var.trusting_role_arn}"
  require_mfa = "${var.require_mfa}"
}

resource "aws_iam_policy" "iam_policy" {
  name        = "${var.trusted_policy_name}"
  description = "Policy to allow assumption of ${var.trusting_role_arn}"
  policy      = "${module.iam_policy_document.iam_policy_json}"
}

resource "aws_iam_group_policy_attachment" "iam_policy_group_attachment" {
  count = "${length(var.trusted_group_names)}"

  group      = "${var.trusted_group_names[count.index]}"
  policy_arn = "${aws_iam_policy.iam_policy.arn}"
}

resource "aws_iam_group_policy_attachment" "iam_policy_role_attachment" {
  count = "${length(var.trusted_role_names)}"

  group      = "${var.trusted_role_names[count.index]}"
  policy_arn = "${aws_iam_policy.iam_policy.arn}"
}
