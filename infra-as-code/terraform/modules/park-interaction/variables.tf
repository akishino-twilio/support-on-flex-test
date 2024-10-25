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
  description = "SID of support everyone queue"
  validation {
    condition     = length(var.support_everyone_queue_sid) > 2 && substr(var.support_everyone_queue_sid, 0, 2) == "WQ"
    error_message = "support_everyone_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_accounts_billing_queue_sid" {
  type        = string
  description = "SID of support accounts_billing queue"
  validation {
    condition     = length(var.support_accounts_billing_queue_sid) > 2 && substr(var.support_accounts_billing_queue_sid, 0, 2) == "WQ"
    error_message = "support_accounts_billing_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_billing_queue_sid" {
  type        = string
  description = "SID of support billing queue"
  validation {
    condition     = length(var.support_billing_queue_sid) > 2 && substr(var.support_billing_queue_sid, 0, 2) == "WQ"
    error_message = "support_billing_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_email_queue_sid" {
  type        = string
  description = "SID of support email queue"
  validation {
    condition     = length(var.support_email_queue_sid) > 2 && substr(var.support_email_queue_sid, 0, 2) == "WQ"
    error_message = "support_email_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_messaging_queue_sid" {
  type        = string
  description = "SID of support messaging queue"
  validation {
    condition     = length(var.support_messaging_queue_sid) > 2 && substr(var.support_messaging_queue_sid, 0, 2) == "WQ"
    error_message = "support_messaging_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_messaging_insights_queue_sid" {
  type        = string
  description = "SID of support messaging_insights queue"
  validation {
    condition     = length(var.support_messaging_insights_queue_sid) > 2 && substr(var.support_messaging_insights_queue_sid, 0, 2) == "WQ"
    error_message = "support_messaging_insights_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_phone_numbers_queue_sid" {
  type        = string
  description = "SID of support phone_numbers queue"
  validation {
    condition     = length(var.support_phone_numbers_queue_sid) > 2 && substr(var.support_phone_numbers_queue_sid, 0, 2) == "WQ"
    error_message = "support_phone_numbers_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_voice_queue_sid" {
  type        = string
  description = "SID of support voice queue"
  validation {
    condition     = length(var.support_voice_queue_sid) > 2 && substr(var.support_voice_queue_sid, 0, 2) == "WQ"
    error_message = "support_voice_queue_sid expected to start with \"WQ\"."
  }
}

variable "chat_channel_sid" {
  type        = string
  description = "SID of chat channel"
  validation {
    condition     = length(var.chat_channel_sid) > 2 && substr(var.chat_channel_sid, 0, 2) == "TC"
    error_message = "chat_channel_sid expected to start with \"TC\"."
  }
}
