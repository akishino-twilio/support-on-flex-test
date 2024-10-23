output "chat_transfer_workflow_sid" {
  value = twilio_taskrouter_workspaces_workflows_v1.live_chat_transfer.sid
  description = "Chat transfer workflow SID"
}
