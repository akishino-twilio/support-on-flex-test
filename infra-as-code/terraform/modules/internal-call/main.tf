terraform {
  required_providers {
    twilio = {
      source  = "twilio/twilio"
      version = ">=0.4.0"
    }
  }
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "internal_calls" {
  workspace_sid  = var.workspace_sid
  friendly_name  = "Internal Calls"
  target_workers = "1==1"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_workflows_v1" "internal_calls" {
  workspace_sid = var.workspace_sid
  friendly_name = "Internal Calls"
  configuration = templatefile("${path.module}/workflows/internal_calls.json", {
    "QUEUE_SID_INTERNAL" = twilio_taskrouter_workspaces_task_queues_v1.internal_calls.sid
    "QUEUE_SID_SUPPORT_EVERYONE" = var.support_everyone_queue_sid
    "QUEUE_SID_SUPPORT_ACCOUNT_ADMINISTRATION" = var.support_accounts_billing_queue_sid
    "QUEUE_SID_SUPPORT_BILLING" = var.support_billing_queue_sid
    "QUEUE_SID_SUPPORT_EMAIL" = var.support_email_queue_sid
    "QUEUE_SID_SUPPORT_MESSAGING" = var.support_messaging_queue_sid
    "QUEUE_SID_SUPPORT_MESSAGING_INSIGHTS" = var.support_messaging_insights_queue_sid
    "QUEUE_SID_SUPPORT_PHONE_NUMBERS" = var.support_phone_numbers_queue_sid
    "QUEUE_SID_SUPPORT_VOICE" = var.support_voice_queue_sid
  })
}
