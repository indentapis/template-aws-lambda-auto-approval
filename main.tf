terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Auto-approval Integration

# Details: https://github.com/indentapis/integrations/tree/d8f5d4b6705d3311a5b4e7c8047fb31812ef6481/packages/stable/indent-integration-auto-approval
# Last Change: https://github.com/indentapis/integrations/commit/d8f5d4b6705d3311a5b4e7c8047fb31812ef6481

module "idt-auto-approval-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-auto-approval-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/auto-approval-d8f5d4b6705d3311a5b4e7c8047fb31812ef6481-function.zip"
    deps_key     = "webhooks/aws/lambda/auto-approval-d8f5d4b6705d3311a5b4e7c8047fb31812ef6481-deps.zip"
  }
  env = {
    AUTO_APPROVAL_DURATION = var.auto_approval_duration
  }
}

