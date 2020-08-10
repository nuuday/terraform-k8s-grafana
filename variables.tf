variable "chart_version" {
  default     = "5.1.4"
  description = "Grafana version to install"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "database_instance_type" {
  default     = "db.t3.micro"
  description = "RDS Database instance type"
  type        = string
}

variable "namespace" {
  default     = "grafana"
  description = "Kubernetes namespace to deploy to"
  type        = string
}

variable "oidc_provider_issuer_url" {
  description = "Issuer used in the OIDC provider associated with the EKS cluster to support IRSA."
  type        = string
}


variable "database_subnets" {
  description = "AWS database subnets"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to taggable resources provisioned by this module."
  type        = map(string)
  default     = {}
}

variable "source_security_group" {
  type        = string
  description = "Source security groups RDS should accept connections from"
}

variable "database_storage_size" {
  description = "Disk space in GB to allocation for RDS instance"
  default     = 5
  type        = number
}

variable "oauth_github_client_id" {
  description = "Github OAUTH client id"
  type        = string
}

variable "oauth_github_client_secret" {
  description = "Github OAUTH client secret"
  type        = string
}

variable "oauth_github_team_ids" {
  description = "Limit access to Grafan from the following teams"
  type        = list(number)
  default     = []
}

variable "oauth_github_organizations" {
  description = "Limit access to Grafana from the following organizations"
  type        = list(string)
  default     = ["nuuday"]
}

variable "auth_enable_basic" {
  default     = true
  description = "Disable basic login"
  type        = bool
}
variable "auth_disable_login_form" {
  default     = false
  description = "Disable login form"
  type        = bool
}
variable "oauth_auto_login" {
  default     = false
  description = "OAuth auto login"
  type        = bool
}

variable "ingress_enabled" {
  type        = bool
  default     = false
  description = "Enable or disable creation of Ingress resources"
}

variable "ingress_hostnames" {
  type        = list(string)
  default     = []
  description = "Ingress hostnames"
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

variable "ingress_class" {
  type        = string
  default     = "nginx"
  description = "Ingress class"
}
