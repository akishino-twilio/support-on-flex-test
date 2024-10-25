terraform {
  required_providers {
    twilio = {
      source  = "twilio/twilio"
      version = ">=0.4.0"
    }
  }
}

resource "twilio_taskrouter_workspaces_workflows_v1" "callback" {
  workspace_sid = var.workspace_sid
  friendly_name = "Callback"
  configuration = templatefile("${path.module}/workflows/callback.json", {
    "QUEUE_SID" = var.queue_sid
  })
}

resource "twilio_studio_flows_v2" "callback_flow" {
  friendly_name  = "Callback Flow"
  status         = "published"
  definition     = templatefile("${path.module}/flows/callback_flow.json", {
    "SERVERLESS_DOMAIN" = var.serverless_domain
    "SERVERLESS_SID" = var.serverless_sid
    "SERVERLESS_ENV_SID" = var.serverless_env_sid
    "FUNCTION_CREATE_CALLBACK" = var.function_create_callback
    "VOICE_CHANNEL_SID" = var.voice_channel_sid
    "WORKFLOW_SID" = twilio_taskrouter_workspaces_workflows_v1.callback.sid
  })
}
