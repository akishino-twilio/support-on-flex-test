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
