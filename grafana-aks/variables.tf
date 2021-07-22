variable "namespace" {
  default     = "grafana"
  description = "Kubernetes namespace to deploy to. This will fail if the namespace already exists."
  type        = string
}

variable "ingress_hostnames" {
  type        = list(string)
  default     = []
  description = "Ingress hostnames"
}

variable "ingress_enabled" {
  type        = bool
  default     = false
  description = "Enable or disable creation of Ingress resources"
}

variable "root_domain" {
  type        = string
  default     = ""
  description = "Root URL for OAuth 2.0 authentication"
}

variable "ingress_cluster_issuer" {
  type        = string
  default     = "letsencrypt"
  description = "Cert-manager cluster issuer"
}

variable "auth_disable_login_form" {
  default     = false
  description = "Disable login form"
  type        = bool
}

variable "datasources" {
  description = "List of data sources to put into Grafana. See https://grafana.com/docs/grafana/latest/administration/provisioning/#datasources for examples."
  default     = []
}

variable "oauth_config" {
  description = "OAuth configuration map for grafana.ini. E.g. `{ auth.github = { ... } }`. See https://grafana.com/docs/grafana/latest/auth/overview/ for a complete list of possible properties for each provider."
  default     = {}
}

variable "tags" {
  description = "Tags to apply to taggable resources provisioned by this module."
  type        = map(string)
  default     = {}
}

variable "release_name" {
  default     = "grafana"
  description = "Helm release name"
  type        = string
}

variable "resource_group" {
  description = "Name of the resource group containing the AKS cluster"
  type        = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_outbound_ips" {
  type = list(string)
}
