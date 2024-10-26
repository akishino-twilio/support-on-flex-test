terraform {
  required_providers {
    twilio = {
      source  = "twilio/twilio"
      version = ">=0.4.0"
    }
  }
}

resource "twilio_taskrouter_workspaces_workflows_v1" "support_voice_personalized" {
  workspace_sid = var.workspace_sid
  friendly_name = "support_voice_personalized"
  configuration = templatefile("${path.module}/workflows/support_voice_personalized.json", {
    "QUEUE_SID_PERSONALIZED_TAM" = var.support_personalized_tam_queue_sid
    "QUEUE_SID_PERSONALIZED_SUPPORT_ENGINEER" = var.support_personalized_support_engineer_queue_sid
  })
}

resource "twilio_studio_flows_v2" "personalized_ivr_flow" {
  friendly_name  = "support-personalized"
  status         = "published"
  definition     = templatefile("${path.module}/flows/personalized_ivr_flow.json", {
    "SUPPORT_AUTHORIZER_DOMAIN" = var.support_authorizer_domain
  })
}
