terraform {
  required_providers {
    twilio = {
      source  = "twilio/twilio"
      version = ">=0.4.0"
    }
  }
}

resource "twilio_taskrouter_workspaces_workflows_v1" "live_chat_transfer" {
  workspace_sid = var.workspace_sid
  friendly_name = "live_chat_transfer"
  configuration = templatefile("${path.module}/workflows/live_chat_transfer.json", {
    "QUEUE_SID_EVERYONE" = var.everyone_queue_sid
    "QUEUE_SID_TEMPLATE_EXAMPLE_SALES" = var.example_sales_queue_sid
    "QUEUE_SID_TEMPLATE_EXAMPLE_SUPPORT" = var.example_support_queue_sid

    "QUEUE_SID_SUPPORT_CHAT_LIVE_CHAT" = var.support_chat_live_chat_queue_sid
    "QUEUE_SID_SUPPORT_CHAT_ACCOUNTS_BILLING" = var.support_chat_accounts_billing_queue_sid
    "QUEUE_SID_SUPPORT_CHAT_BILLING" = var.support_chat_billing_queue_sid
    "QUEUE_SID_SUPPORT_CHAT_EMAIL" = var.support_chat_email_queue_sid
    "QUEUE_SID_SUPPORT_CHAT_MESSAGING" = var.support_chat_messaging_queue_sid
    "QUEUE_SID_SUPPORT_CHAT_MESSAGING_INSIGHTS" = var.support_chat_messaging_insights_queue_sid
    "QUEUE_SID_SUPPORT_CHAT_PHONE_NUMBERS" = var.support_chat_phone_numbers_queue_sid
    "QUEUE_SID_SUPPORT_CHAT_VOICE" = var.support_chat_voice_queue_sid
  })
}
