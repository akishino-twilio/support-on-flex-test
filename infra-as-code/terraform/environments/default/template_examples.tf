# FEATURE: remove-all
resource "twilio_taskrouter_workspaces_task_queues_v1" "template_example_everyone" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Template Example Everyone"
  target_workers = "1==1"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "template_example_sales" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Template Example Sales"
  target_workers = "routing.skills HAS 'template_example_sales'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "template_example_support" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Template Example Support"
  target_workers = "routing.skills HAS 'template_example_support'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_workflows_v1" "template_example_assign_to_anyone" {
  workspace_sid = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name = "Template Example Assign to Anyone"
  configuration = templatefile("workflows/template_example_assign_to_anyone.json", {
    "QUEUE_SID_EVERYONE" = twilio_taskrouter_workspaces_task_queues_v1.template_example_everyone.sid
    "QUEUE_SID_TEMPLATE_EXAMPLE_SALES" = twilio_taskrouter_workspaces_task_queues_v1.template_example_sales.sid
    "QUEUE_SID_TEMPLATE_EXAMPLE_SUPPORT" = twilio_taskrouter_workspaces_task_queues_v1.template_example_support.sid
  })
}
# END FEATURE: remove-all

### Support on Flex resources ###
resource "twilio_taskrouter_workspaces_task_queues_v1" "support_chat_live_chat" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Live Chat (Everyone)"
  target_workers = "1==1"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_chat_accounts_billing" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Accounts Billing"
  target_workers = "routing.skills HAS 'support_accounts_billing'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_chat_billing" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Billing"
  target_workers = "routing.skills HAS 'support_billing'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_chat_email" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Email"
  target_workers = "(routing.skills HAS 'email') OR (routing.skills HAS 'support_email')"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_chat_messaging" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Messaging"
  target_workers = "routing.skills HAS 'support_messaging'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_chat_messaging_insights" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Messaging Insights"
  target_workers = "routing.skills HAS 'support_messaging_insights'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_chat_phone_numbers" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Phone Numbers"
  target_workers = "routing.skills HAS 'support_phone_numbers'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_chat_voice" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Voice"
  target_workers = "routing.skills HAS 'support_voice'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_voice_personalized_tam" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Personalized TAM (Voice)"
  target_workers = "routing.skills HAS 'support_personalized_tam'"
  max_reserved_workers = 1
  task_order = "FIFO"
}

resource "twilio_taskrouter_workspaces_task_queues_v1" "support_voice_personalized_support_engineer" {
  workspace_sid  = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name  = "Personalized Support Engineer (Voice)"
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

resource "twilio_taskrouter_workspaces_workflows_v1" "support_chat_live_chat" {
  workspace_sid = var.TWILIO_FLEX_WORKSPACE_SID
  friendly_name = "Support Live Chat"
  configuration = templatefile("workflows/support_chat_live_chat.json", {
    "QUEUE_SID_SUPPORT_CHAT_LIVE_CHAT" = twilio_taskrouter_workspaces_task_queues_v1.support_chat_live_chat.sid
    "QUEUE_SID_SUPPORT_CHAT_EMAIL" = twilio_taskrouter_workspaces_task_queues_v1.support_chat_email.sid
    "QUEUE_SID_SUPPORT_CHAT_ACCOUNTS_BILLING" = twilio_taskrouter_workspaces_task_queues_v1.support_chat_accounts_billing.sid
    "QUEUE_SID_SUPPORT_CHAT_PHONE_NUMBERS" = twilio_taskrouter_workspaces_task_queues_v1.support_chat_phone_numbers.sid
    "QUEUE_SID_SUPPORT_CHAT_MESSAGING" = twilio_taskrouter_workspaces_task_queues_v1.support_chat_messaging.sid
    "QUEUE_SID_SUPPORT_CHAT_VOICE" = twilio_taskrouter_workspaces_task_queues_v1.support_chat_voice.sid
    "QUEUE_SID_SUPPORT_CHAT_BILLING" = twilio_taskrouter_workspaces_task_queues_v1.support_chat_billing.sid
    "QUEUE_SID_SUPPORT_CHAT_MESSAGING_INSIGHTS" = twilio_taskrouter_workspaces_task_queues_v1.support_chat_messaging_insights.sid
  })
}
