variable "workspace_sid" {
  type        = string
  description = "TaskRouter workspace SID"
  validation {
    condition     = length(var.workspace_sid) > 2 && substr(var.workspace_sid, 0, 2) == "WS"
    error_message = "workspace_sid expected to start with \"WS\"."
  }
}

variable "everyone_queue_sid" {
  type        = string
  description = "SID of everyone queue"
  validation {
    condition     = length(var.everyone_queue_sid) > 2 && substr(var.everyone_queue_sid, 0, 2) == "WQ"
    error_message = "everyone_queue_sid expected to start with \"WQ\"."
  }
}

variable "example_sales_queue_sid" {
  type        = string
  description = "SID of example sales queue"
  validation {
    condition     = length(var.example_sales_queue_sid) > 2 && substr(var.example_sales_queue_sid, 0, 2) == "WQ"
    error_message = "example_sales_queue_sid expected to start with \"WQ\"."
  }
}

variable "example_support_queue_sid" {
  type        = string
  description = "SID of example support queue"
  validation {
    condition     = length(var.example_support_queue_sid) > 2 && substr(var.example_support_queue_sid, 0, 2) == "WQ"
    error_message = "example_support_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_chat_live_chat_queue_sid" {
  type        = string
  description = "SID of support_chat_live_chat queue"
  validation {
    condition     = length(var.support_chat_live_chat_queue_sid) > 2 && substr(var.support_chat_live_chat_queue_sid, 0, 2) == "WQ"
    error_message = "support_chat_live_chat_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_chat_accounts_billing_queue_sid" {
  type        = string
  description = "SID of support_chat_accounts_billing queue"
  validation {
    condition     = length(var.support_chat_accounts_billing_queue_sid) > 2 && substr(var.support_chat_accounts_billing_queue_sid, 0, 2) == "WQ"
    error_message = "support_chat_accounts_billing_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_chat_billing_queue_sid" {
  type        = string
  description = "SID of support_chat_billing queue"
  validation {
    condition     = length(var.support_chat_billing_queue_sid) > 2 && substr(var.support_chat_billing_queue_sid, 0, 2) == "WQ"
    error_message = "support_chat_billing_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_chat_email_queue_sid" {
  type        = string
  description = "SID of support_chat_email queue"
  validation {
    condition     = length(var.support_chat_email_queue_sid) > 2 && substr(var.support_chat_email_queue_sid, 0, 2) == "WQ"
    error_message = "support_chat_email_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_chat_messaging_queue_sid" {
  type        = string
  description = "SID of support_chat_messaging queue"
  validation {
    condition     = length(var.support_chat_messaging_queue_sid) > 2 && substr(var.support_chat_messaging_queue_sid, 0, 2) == "WQ"
    error_message = "support_chat_messaging_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_chat_messaging_insights_queue_sid" {
  type        = string
  description = "SID of support_chat_messaging_insights queue"
  validation {
    condition     = length(var.support_chat_messaging_insights_queue_sid) > 2 && substr(var.support_chat_messaging_insights_queue_sid, 0, 2) == "WQ"
    error_message = "support_chat_messaging_insights_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_chat_phone_numbers_queue_sid" {
  type        = string
  description = "SID of support_chat_phone_numbers queue"
  validation {
    condition     = length(var.support_chat_phone_numbers_queue_sid) > 2 && substr(var.support_chat_phone_numbers_queue_sid, 0, 2) == "WQ"
    error_message = "support_chat_phone_numbers_queue_sid expected to start with \"WQ\"."
  }
}

variable "suppor_chat_voice_queue_sid" {
  type        = string
  description = "SID of suppor_chat_voice queue"
  validation {
    condition     = length(var.suppor_chat_voice_queue_sid) > 2 && substr(var.suppor_chat_voice_queue_sid, 0, 2) == "WQ"
    error_message = "suppor_chat_voice_queue_sid expected to start with \"WQ\"."
  }
}
