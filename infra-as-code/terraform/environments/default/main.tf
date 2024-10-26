### Support on Flex Task Queues ###
resource "twilio_taskrouter_workspaces_task_queues_v1" "support_everyone" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Everyone"
  target_workers = "1==1"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_accounts_billing" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Account Administration"
  target_workers = "routing.skills HAS 'support_accounts_billing'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_billing" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Billing"
  target_workers = "routing.skills HAS 'support_billing'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_email" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Email"
  target_workers = "(routing.skills HAS 'email') OR (routing.skills HAS 'support_email')"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_messaging" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Messaging"
  target_workers = "routing.skills HAS 'support_messaging'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_messaging_insights" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Messaging Insights"
  target_workers = "routing.skills HAS 'support_messaging_insights'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_phone_numbers" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Phone Numbers"
  target_workers = "routing.skills HAS 'support_phone_numbers'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_voice" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Voice"
  target_workers = "routing.skills HAS 'support_voice'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_personalized_tam" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Personalized TAM"
  target_workers = "routing.skills HAS 'support_personalized_tam'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_personalized_support_engineer" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Personalized Support Engineer"
  target_workers = "routing.skills HAS 'support_personalized_support_engineer'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_voicemail_personalized" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Personalized (Voicemail)"
  target_workers = "routing.skills HAS 'support_personalized_support_engineer'"
  max_reserved_workers = 4
  task_order = "FIFO"
}

### Support on Flex Workflows ###
resource "twilio_taskrouter_workspaces_workflows_v1" "support_live_chat" {
  workspace_sid = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name = "Support Live Chat"
  configuration = templatefile("workflows/support_live_chat.json", {
    "QUEUE_SID_SUPPORT_EVERYONE" = twilio_taskrouter_workspaces_task_queues_v1.support_everyone.sid
    "QUEUE_SID_SUPPORT_ACCOUNT_ADMINISTRATION" = twilio_taskrouter_workspaces_task_queues_v1.support_accounts_billing.sid
    "QUEUE_SID_SUPPORT_BILLING" = twilio_taskrouter_workspaces_task_queues_v1.support_billing.sid
    "QUEUE_SID_SUPPORT_EMAIL" = twilio_taskrouter_workspaces_task_queues_v1.support_email.sid
    "QUEUE_SID_SUPPORT_MESSAGING" = twilio_taskrouter_workspaces_task_queues_v1.support_messaging.sid
    "QUEUE_SID_SUPPORT_MESSAGING_INSIGHTS" = twilio_taskrouter_workspaces_task_queues_v1.support_messaging_insights.sid
    "QUEUE_SID_SUPPORT_PHONE_NUMBERS" = twilio_taskrouter_workspaces_task_queues_v1.support_phone_numbers.sid
    "QUEUE_SID_SUPPORT_VOICE" = twilio_taskrouter_workspaces_task_queues_v1.support_voice.sid
  })
}

### Support on Flex Task Channels ###
resource "twilio_taskrouter_workspaces_task_channels_v1" "voice" {
  workspace_sid	= var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name	= "Voice"
  unique_name = "voice"
}

resource "twilio_taskrouter_workspaces_task_channels_v1" "chat" {
  workspace_sid	= var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name	= "Chat"
  unique_name = "chat"
}

# FEATURE: personalized-ivr
module "personalized-ivr" {
  source = "../../modules/personalized-ivr"

  support_authorizer_domain = var.SUPPORT_AUTHORIZER_DOMAIN
}
# END FEATURE: personalized-ivr

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
  chat_channel_sid = twilio_taskrouter_workspaces_task_channels_v1.chat.sid
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
  workflow_sid = twilio_taskrouter_workspaces_workflows_v1.support_live_chat.sid

  schedule_manager_domain = var.SCHEDULE_MANAGER_DOMAIN
  schedule_manager_sid = var.SCHEDULE_MANAGER_SID
  schedule_manager_env_sid = var.SCHEDULE_MANAGER_ENV_SID
  function_check_schedule_sid = var.SCHEDULE_MANAGER_CHECK_FUNCTION_SID
}
# END FEATURE: schedule-manager
