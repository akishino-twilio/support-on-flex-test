#!/bin/bash
# This script will import the project workflows, queues, channels, activities, and flows for the first time and apply them with Terraform.
set -e

terraform -chdir="../terraform/environments/default" init -input=false

get_value_from_json() {
	input_json="$1"
	key="$2"
	value="$3"
	property="$4"

	filtered_output=$(echo "$input_json" | jq --arg key "$key" --arg value "$value" '.[] | select(.[$key] == $value) // empty' | jq -r ".$property// \"\"")
	echo "$filtered_output"

}

import_resource() {
	input_json="$1"
	name="$2"
	resource="$3"
	key="$4"
	has_sid=${5:-true}

	result=$(get_value_from_json "$input_json" "$key" "$name" "sid")
	if [ -n "$result" ]; then
		if $has_sid; then
			terraform -chdir="../terraform/environments/default" import -input=false -var-file="${ENVIRONMENT:-local}.tfvars" "$resource" "$TF_WORKSPACE_SID"/"$result" || exit
		else
			terraform -chdir="../terraform/environments/default" import -input=false -var-file="${ENVIRONMENT:-local}.tfvars" "$resource" "$result" || exit
		fi
	fi

}

importInternalState() {
	echo " - Discovering and importing existing Twilio state for known definitions into a new terraform state file" >>$GITHUB_STEP_SUMMARY
	TF_WORKSPACE_SID=$(cat "../terraform/environments/default/${ENVIRONMENT:-local}.tfvars" | grep "TWILIO_FLEX_WORKSPACE_SID" | sed 's/ = /=/;s/^\([^ ]*\)="\([^"].*\)"/\2/')

	workflows=$(npx twilio api:taskrouter:v1:workspaces:workflows:list --workspace-sid "$TF_WORKSPACE_SID" --no-limit -o json | jq 'map(del(.configuration))')
	queues=$(npx twilio api:taskrouter:v1:workspaces:task-queues:list --workspace-sid "$TF_WORKSPACE_SID" --no-limit -o json)
	channels=$(npx twilio api:taskrouter:v1:workspaces:task-channels:list --workspace-sid "$TF_WORKSPACE_SID" --no-limit -o json)
	activities=$(npx twilio api:taskrouter:v1:workspaces:activities:list --workspace-sid "$TF_WORKSPACE_SID" --no-limit -o json)
	flows=$(npx twilio api:studio:v2:flows:list --no-limit -o json)

	# FEATURE: remove-all
	import_resource "$workflows" "Support Live Chat" "twilio_taskrouter_workspaces_workflows_v1.support_live_chat" "friendlyName"
	import_resource "$queues" "Everyone" "twilio_taskrouter_workspaces_task_queues_v1.support_everyone" "friendlyName"
	import_resource "$queues" "Account Administration" "twilio_taskrouter_workspaces_task_queues_v1.support_accounts_billing" "friendlyName"
	import_resource "$queues" "Billing" "twilio_taskrouter_workspaces_task_queues_v1.support_billing" "friendlyName"
	import_resource "$queues" "Email" "twilio_taskrouter_workspaces_task_queues_v1.support_email" "friendlyName"
	import_resource "$queues" "Messaging" "twilio_taskrouter_workspaces_task_queues_v1.support_messaging" "friendlyName"
	import_resource "$queues" "Messaging Insights" "twilio_taskrouter_workspaces_task_queues_v1.support_messaging_insights" "friendlyName"
	import_resource "$queues" "Phone Numbers" "twilio_taskrouter_workspaces_task_queues_v1.support_phone_numbers" "friendlyName"
	import_resource "$queues" "Voice" "twilio_taskrouter_workspaces_task_queues_v1.support_voice" "friendlyName"
	import_resource "$queues" "Personalized TAM" "twilio_taskrouter_workspaces_task_queues_v1.support_personalized_tam" "friendlyName"
	import_resource "$queues" "Personalized Support Engineer" "twilio_taskrouter_workspaces_task_queues_v1.support_personalized_support_engineer" "friendlyName"
	import_resource "$queues" "Personalized (Voicemail)" "twilio_taskrouter_workspaces_task_queues_v1.support_voicemail_personalized" "friendlyName"
	import_resource "$channels" "chat" "twilio_taskrouter_workspaces_task_channels_v1.chat" "uniqueName"
	import_resource "$channels" "voice" "twilio_taskrouter_workspaces_task_channels_v1.voice" "uniqueName"
	echo "   - :white_check_mark: Example TaskRouter resources" >>$GITHUB_STEP_SUMMARY
	# END FEATURE: remove-all

	# FEATURE: conversation-transfer
	import_resource "$workflows" "Live Chat Transfer" "module.conversation-transfer.twilio_taskrouter_workspaces_workflows_v1.live_chat_transfer" "friendlyName"
	echo "   - :white_check_mark: conversation-transfer resources" >>$GITHUB_STEP_SUMMARY
	# END FEATURE: conversation-transfer

	# FEATURE: callback-and-voicemail
	import_resource "$workflows" "Callback" "module.callback-and-voicemail.twilio_taskrouter_workspaces_workflows_v1.callback" "friendlyName"
	import_resource "$flows" "Callback Flow" "module.callback-and-voicemail.twilio_studio_flows_v2.callback_flow" "friendlyName" false
	echo "   - :white_check_mark: callback-and-voicemail resources" >>$GITHUB_STEP_SUMMARY
	# END FEATURE: callback-and-voicemail

	# FEATURE: internal-call
	import_resource "$workflows" "Internal Calls" "module.internal-call.twilio_taskrouter_workspaces_workflows_v1.internal_calls" "friendlyName"
	import_resource "$queues" "Internal Calls" "module.internal-call.twilio_taskrouter_workspaces_task_queues_v1.internal_calls" "friendlyName"
	echo "   - :white_check_mark: internal-call resources" >>$GITHUB_STEP_SUMMARY
	# END FEATURE: internal-call

	# FEATURE: park-interaction
	import_resource "$workflows" "Park/Resume" "module.park-interaction.twilio_taskrouter_workspaces_workflows_v1.park_resume" "friendlyName"
	import_resource "$flows" "Messaging with Parking Flow" "module.park-interaction.twilio_studio_flows_v2.messaging_with_parking_flow" "friendlyName" false
	echo "   - :white_check_mark: park-interaction resources" >>$GITHUB_STEP_SUMMARY
	# END FEATURE: park-interaction

	# FEATURE: activity-reservation-handler
	import_resource "$activities" "On a Task" "module.activity-reservation-handler.twilio_taskrouter_workspaces_activities_v1.on_a_task" "friendlyName"
	import_resource "$activities" "On a Task, No ACD" "module.activity-reservation-handler.twilio_taskrouter_workspaces_activities_v1.on_a_task_no_acd" "friendlyName"
	import_resource "$activities" "Wrap Up" "module.activity-reservation-handler.twilio_taskrouter_workspaces_activities_v1.wrap_up" "friendlyName"
	import_resource "$activities" "Wrap Up, No ACD" "module.activity-reservation-handler.twilio_taskrouter_workspaces_activities_v1.wrap_up_no_acd" "friendlyName"
	import_resource "$activities" "Extended Wrap Up" "module.activity-reservation-handler.twilio_taskrouter_workspaces_activities_v1.extended_wrap_up" "friendlyName"
	echo "   - :white_check_mark: activity-reservation-handler resources" >>$GITHUB_STEP_SUMMARY
	# END FEATURE: activity-reservation-handler

	# FEATURE: schedule-manager
	import_resource "$flows" "Schedule Flow" "module.schedule-manager.twilio_studio_flows_v2.schedule_flow" "friendlyName" false
	echo "   - :white_check_mark: schedule-manager resources" >>$GITHUB_STEP_SUMMARY
	# END FEATURE: schedule-manager
}

# populate tfvars
(cd ../.. && npm run postinstall -- --skip-packages --files=infra-as-code/terraform/environments/default/example.tfvars)

### only if existing state file does not exist
### do we want to import the internal state
if ! [ -f ../terraform/environments/default/terraform.tfstate ]; then
	importInternalState
fi

retries=3
count=0
delay=5

### terraform apply may fail due to rate limits when creating new resources. Retrying if it fails
while [ $count -lt $retries ]; do
	terraform -chdir="../terraform/environments/default" apply -input=false -auto-approve -var-file="${ENVIRONMENT:-local}.tfvars" || true
	exit_status=$?

	if [ $exit_status -eq 0 ]; then
		echo " - Applying terraform configuration complete" >>$GITHUB_STEP_SUMMARY
		echo "JOB_FAILED=false" >>"$GITHUB_OUTPUT"
		exit 0
	fi
	echo " - Terraform apply failed. Retrying in $delay seconds..." >>$GITHUB_STEP_SUMMARY
	sleep $delay
	count=$((count + 1))
	delay=$((delay * 2))
done

echo " - Applying terraform configuration failed after $retries attempts" >>$GITHUB_STEP_SUMMARY
echo "JOB_FAILED=true" >>"$GITHUB_OUTPUT"
exit 0
