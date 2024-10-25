output "callback_workflow_sid" {
  value = twilio_taskrouter_workspaces_workflows_v1.callback.sid
  description = "Callback workflow SID"
}

output "callback_flow_sid" {
  value = twilio_studio_flows_v2.callback_flow.sid
  description = "Callback flow SID"
}
