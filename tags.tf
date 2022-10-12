locals {
  #tflint-ignore: terraform_unused_declarations -- Ignoring warning of unused declaration as this declaration will be called during module instantiation
  common_tags = merge(var.input_tags, {
    "ModuleSourceRepo" = "github.com/StratusGrid/terraform-aws-iam-cross-account-trust-maps"
  })
}
