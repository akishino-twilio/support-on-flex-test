variable "workspace_sid" {
  type        = string
  description = "TaskRouter workspace SID"
  validation {
    condition     = length(var.workspace_sid) > 2 && substr(var.workspace_sid, 0, 2) == "WS"
    error_message = "workspace_sid expected to start with \"WS\"."
  }
}

variable "support_authorizer_domain" {
  type        = string
  description = "support authorizer domain for studio proxy"
  validation {
    condition     = length(var.support_authorizer_domain) > 36 && substr(var.support_authorizer_domain, 10, 46) == ".execute-api.us-east-1.amazonaws.com"
    error_message = "support_authorizer_domain expected to end with with \".execute-api.us-east-1.amazonaws.com\"."
  }
}

variable "support_personalized_tam_queue_sid" {
  type        = string
  description = "SID of support_personalized_tam queue"
  validation {
    condition     = length(var.support_personalized_tam_queue_sid) > 2 && substr(var.support_personalized_tam_queue_sid, 0, 2) == "WQ"
    error_message = "support_personalized_tam_queue_sid expected to start with \"WQ\"."
  }
}

variable "support_personalized_support_engineer_queue_sid" {
  type        = string
  description = "SID of support_personalized_support_engineer queue"
  validation {
    condition     = length(var.support_personalized_support_engineer_queue_sid) > 2 && substr(var.support_personalized_support_engineer_queue_sid, 0, 2) == "WQ"
    error_message = "support_personalized_support_engineer_queue_sid expected to start with \"WQ\"."
  }
}
