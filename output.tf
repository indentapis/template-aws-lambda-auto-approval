output "idt-auto-approval-webhook-url" {
  value       = module.idt-auto-approval-webhook.function_url
  description = "The URL of the deployed Lambda"
}

