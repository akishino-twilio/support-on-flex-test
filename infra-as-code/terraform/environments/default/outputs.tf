# these aren't used for anything other than debug output within the CI workflow.

# FEATURE: remove-all
output "support_live_chat_workflow_sid" {
  value = twilio_taskrouter_workspaces_workflows_v1.support_live_chat.sid
  description = "Assign to anyone in support workflow SID"
}
# END FEATURE: remove-all

# FEATURE: personalized-ivr
output "personalized_ivr_flow_sid" {
  value = module.personalized-ivr.personalized_ivr_flow_sid
  description = "Personalized IVR flow SID"
}
# END FEATURE: personalized-ivr


# FEATURE: callback-and-voicemail
output "callback_workflow_sid" {
  value = module.callback-and-voicemail.callback_workflow_sid
  description = "Callback workflow SID"
}

output "callback_flow_sid" {
  value = module.callback-and-voicemail.callback_flow_sid
  description = "Example callback flow SID"
}
# END FEATURE: callback-and-voicemail

# FEATURE: conversation-transfer
output "chat_transfer_workflow_sid" {
  value = module.conversation-transfer.chat_transfer_workflow_sid
  description = "Chat transfer workflow SID"
}
# END FEATURE: conversation-transfer

# FEATURE: internal-call
output "internal_call_workflow_sid" {
  value = module.internal-call.internal_call_workflow_sid
  description = "Internal call workflow SID"
}
# END FEATURE: internal-call

# FEATURE: park-interaction
output "park_resume_workflow_sid" {
  value = module.park-interaction.park_resume_workflow_sid
  description = "Park/resume workflow SID"
}

output "parking_flow_sid" {
  value = module.park-interaction.parking_flow_sid
  description = "Messaging with parking flow SID"
}
# END FEATURE: park-interaction

# FEATURE: schedule-manager
output "schedule_flow_sid" {
  value = module.schedule-manager.schedule_flow_sid
  description = "Schedule flow SID"
}
# END FEATURE: schedule-manager
