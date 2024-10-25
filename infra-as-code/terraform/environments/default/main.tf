# FEATURE: remove-all
resource "twilio_taskrouter_workspaces_task_channels_v1" "voice" {
  workspace_sid	= var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name	= "Voice"
  unique_name = "voice"
}
# END FEATURE: remove-all

# FEATURE: activity-reservation-handler
module "activity-reservation-handler" {
  source = "../../modules/activity-reservation-handler"

  workspace_sid = var.TWILIO_FLEX_WORKSPACE_SID
}
# END FEATURE: activity-reservation-handler

# FEATURE: callback-and-voicemail
module "callback-and-voicemail" {
  source = "../../modules/callback-and-voicemail"

  workspace_sid = var.TWILIO_FLEX_WORKSPACE_SID
  voice_channel_sid = twilio_taskrouter_workspaces_task_channels_v1.voice.sid
  queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_everyone.sid

  serverless_domain = var.SERVERLESS_DOMAIN
  serverless_sid = var.SERVERLESS_SID
  serverless_env_sid = var.SERVERLESS_ENV_SID
  function_create_callback = var.SERVERLESS_CALLBACK_FUNCTION_SID
}
# END FEATURE: callback-and-voicemail

# FEATURE: conversation-transfer
module "conversation-transfer" {
  source = "../../modules/conversation-transfer"

  workspace_sid = var.TWILIO_FLEX_WORKSPACE_SID
  support_everyone_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_everyone.sid
  support_accounts_billing_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_accounts_billing.sid
  support_billing_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_billing.sid
  support_email_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_email.sid
  support_messaging_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_messaging.sid
  support_messaging_insights_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_messaging_insights.sid
  support_phone_numbers_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_phone_numbers.sid
  support_voice_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_voice.sid
}
# END FEATURE: conversation-transfer

# FEATURE: internal-call
module "internal-call" {
  source = "../../modules/internal-call"

  workspace_sid = var.TWILIO_FLEX_WORKSPACE_SID
  support_everyone_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_everyone.sid
  support_accounts_billing_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_accounts_billing.sid
  support_billing_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_billing.sid
  support_email_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_email.sid
  support_messaging_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_messaging.sid
  support_messaging_insights_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_messaging_insights.sid
  support_phone_numbers_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_phone_numbers.sid
  support_voice_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_voice.sid
}
# END FEATURE: internal-call

# FEATURE: park-interaction
module "park-interaction" {
  source = "../../modules/park-interaction"

  workspace_sid = var.TWILIO_FLEX_WORKSPACE_SID
  support_everyone_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_everyone.sid
  support_accounts_billing_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_accounts_billing.sid
  support_billing_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_billing.sid
  support_email_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_email.sid
  support_messaging_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_messaging.sid
  support_messaging_insights_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_messaging_insights.sid
  support_phone_numbers_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_phone_numbers.sid
  support_voice_queue_sid = twilio_taskrouter_workspaces_task_queues_v1.support_voice.sid
}
# END FEATURE: park-interaction

# FEATURE: schedule-manager
module "schedule-manager" {
  source = "../../modules/schedule-manager"

  voice_channel_sid = twilio_taskrouter_workspaces_task_channels_v1.voice.sid
  # [TODO] Update this workflow SID to the correct workflow for voice calls
  workflow_sid = twilio_taskrouter_workspaces_workflows_v1.support_chat_live_chat.sid

  schedule_manager_domain = var.SCHEDULE_MANAGER_DOMAIN
  schedule_manager_sid = var.SCHEDULE_MANAGER_SID
  schedule_manager_env_sid = var.SCHEDULE_MANAGER_ENV_SID
  function_check_schedule_sid = var.SCHEDULE_MANAGER_CHECK_FUNCTION_SID
}
# END FEATURE: schedule-manager
