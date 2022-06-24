terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Auto-approval Integration

# Details: https://github.com/indentapis/integrations/tree/255f8fc40009c53806216cb5fc6cd185e2cd5eda/packages/stable/indent-integration-auto-approval
# Last Change: https://github.com/indentapis/integrations/commit/255f8fc40009c53806216cb5fc6cd185e2cd5eda

module "idt-auto-approval-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-auto-approval-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/auto-approval-255f8fc40009c53806216cb5fc6cd185e2cd5eda-function.zip"
    deps_key     = "webhooks/aws/lambda/auto-approval-255f8fc40009c53806216cb5fc6cd185e2cd5eda-deps.zip"
  }
  env = {
    AUTO_APPROVAL_DURATION = var.auto_approval_duration
  }
}

