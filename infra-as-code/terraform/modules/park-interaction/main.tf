terraform {
  required_providers {
    twilio = {
      source  = "twilio/twilio"
      version = ">=0.4.0"
    }
  }
}

resource "twilio_taskrouter_workspaces_workflows_v1" "park_resume" {
  workspace_sid = var.workspace_sid
  friendly_name = "Park/Resume"
  configuration = templatefile("${path.module}/workflows/park_resume.json", {
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

resource "twilio_studio_flows_v2" "messaging_with_parking_flow" {
  friendly_name  = "Messaging with Parking Flow"
  status         = "published"
  definition     = templatefile("${path.module}/flows/messaging_with_parking_flow.json", {
    "CHAT_CHANNEL_SID" = var.chat_channel_sid
    "WORKFLOW_SID" = twilio_taskrouter_workspaces_workflows_v1.park_resume.sid
  })
}
