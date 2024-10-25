variable "workspace_sid" {
  type        = string
  description = "TaskRouter workspace SID"
  validation {
    condition     = length(var.workspace_sid) > 2 && substr(var.workspace_sid, 0, 2) == "WS"
    error_message = "workspace_sid expected to start with \"WS\"."
  }
}

variable "support_everyone_queue_sid" {
  type        = string
  description = "SID of support_everyone queue"
  validation {
    condition     = length(var.support_everyone_queue_sid) > 2 && substr(var.support_everyone_queue_sid, 0, 2) == "WQ"
    error_message = "support_everyone_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_accounts_billing_queue_sid" {
  type        = string
  description = "SID of support_accounts_billing queue"
  validation {
    condition     = length(var.support_accounts_billing_queue_sid) > 2 && substr(var.support_accounts_billing_queue_sid, 0, 2) == "WQ"
    error_message = "support_accounts_billing_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_billing_queue_sid" {
  type        = string
  description = "SID of support_billing queue"
  validation {
    condition     = length(var.support_billing_queue_sid) > 2 && substr(var.support_billing_queue_sid, 0, 2) == "WQ"
    error_message = "support_billing_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_email_queue_sid" {
  type        = string
  description = "SID of support_email queue"
  validation {
    condition     = length(var.support_email_queue_sid) > 2 && substr(var.support_email_queue_sid, 0, 2) == "WQ"
    error_message = "support_email_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_messaging_queue_sid" {
  type        = string
  description = "SID of support_messaging queue"
  validation {
    condition     = length(var.support_messaging_queue_sid) > 2 && substr(var.support_messaging_queue_sid, 0, 2) == "WQ"
    error_message = "support_messaging_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_messaging_insights_queue_sid" {
  type        = string
  description = "SID of support_messaging_insights queue"
  validation {
    condition     = length(var.support_messaging_insights_queue_sid) > 2 && substr(var.support_messaging_insights_queue_sid, 0, 2) == "WQ"
    error_message = "support_messaging_insights_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_phone_numbers_queue_sid" {
  type        = string
  description = "SID of support_phone_numbers queue"
  validation {
    condition     = length(var.support_phone_numbers_queue_sid) > 2 && substr(var.support_phone_numbers_queue_sid, 0, 2) == "WQ"
    error_message = "support_phone_numbers_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_voice_queue_sid" {
  type        = string
  description = "SID of support_voice queue"
  validation {
    condition     = length(var.support_voice_queue_sid) > 2 && substr(var.support_voice_queue_sid, 0, 2) == "WQ"
    error_message = "support_voice_queue_sid expected to start with \"WQ\"."
  }
}
