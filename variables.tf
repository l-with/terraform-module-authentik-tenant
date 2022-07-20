variable "authentik_url" {
  description = "the url of the authentik instance"
  type        = string
}

variable "authentik_token" {
  description = "the token for the authentik"
  type        = string
  sensitive   = true
}

variable "authentik_default_tenant_domain" {
  description = "the domain for selecting the authentik default tenant"
  type        = string
  default     = "authentik-default"
}

variable "authentik_default_tenant_default" {
  description = "if the authentik default tenant should become default"
  type        = bool
  default     = false
}
