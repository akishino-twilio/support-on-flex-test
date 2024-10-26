terraform {
  required_providers {
    twilio = {
      source  = "twilio/twilio"
      version = ">=0.4.0"
    }
  }
}

resource "twilio_studio_flows_v2" "personalized_ivr_flow" {
  friendly_name  = "support-personalized"
  status         = "published"
  definition     = templatefile("${path.module}/flows/personalized_ivr_flow.json", {
    "SUPPORT_AUTHORIZER_DOMAIN" = var.support_authorizer_domain
  })
}
