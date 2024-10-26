variable "support_authorizer_domain" {
  type        = string
  description = "support authorizer domain for studio proxy"
  validation {
    condition     = length(var.support_authorizer_domain) > 36 && substr(var.support_authorizer_domain, 10, 46) == ".execute-api.us-east-1.amazonaws.com"
    error_message = "support_authorizer_domain expected to end with with \".execute-api.us-east-1.amazonaws.com\"."
  }
}
