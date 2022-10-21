terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Auto-approval Integration

# Details: https://github.com/indentapis/integrations/tree/f494cef86094c3b40ac124e3159f5f3391c7e6c8/packages/stable/indent-integration-auto-approval
# Last Change: https://github.com/indentapis/integrations/commit/f494cef86094c3b40ac124e3159f5f3391c7e6c8

module "idt-auto-approval-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-auto-approval-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/auto-approval-f494cef86094c3b40ac124e3159f5f3391c7e6c8-function.zip"
    deps_key     = "webhooks/aws/lambda/auto-approval-f494cef86094c3b40ac124e3159f5f3391c7e6c8-deps.zip"
  }
  env = {
    AUTO_APPROVAL_DURATION = var.auto_approval_duration
  }
}

