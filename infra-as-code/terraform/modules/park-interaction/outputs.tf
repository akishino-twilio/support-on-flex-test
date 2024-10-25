output "park_resume_workflow_sid" {
  value = twilio_taskrouter_workspaces_workflows_v1.park_resume.sid
  description = "Park/resume workflow SID"
}

output "parking_flow_sid" {
  value = twilio_studio_flows_v2.messaging_with_parking_flow.sid
  description = "Messaging with parking flow SID"
}
