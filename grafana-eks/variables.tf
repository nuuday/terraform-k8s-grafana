variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "database_instance_type" {
  default     = "db.t3.micro"
  description = "RDS Database instance type"
  type        = string
}

variable "database_skip_final_snapshot" {
  default     = true
  description = "Set to true if you /don't/ want to save user defined graphs when running terraform destroy"
  type        = bool
}

variable "database_final_snapshot_identifier" {
  default     = "grafana-snapshot"
  description = "Snapshot saved when running terraform destroy. Please set/rename if you have more clusters using the same RDS"
  type        = string
}

variable "database_snapshot_identifier" {
  default     = null
  description = "Name of snapshot of database used when applying. Will only work if the snapshot actually exists"
  type        = string
}

variable "namespace" {
  default     = "grafana"
  description = "Kubernetes namespace to deploy to. This will fail if the namespace already exists."
  type        = string
}

variable "release_name" {
  default     = "grafana"
  description = "Helm release name"
  type        = string
}

variable "oidc_provider_issuer_url" {
  description = "Issuer used in the OIDC provider associated with the EKS cluster to support IRSA."
  type        = string
}

variable "additional_irsa_role_policy_arns" {
  description = "Additional policy ARNs to attach the Grafana IAM role assumed by Grafana through IRSA."
  type        = list(string)
  default     = []
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

variable "oauth_config" {
  description = "OAuth configuration map for grafana.ini. E.g. `{ auth.github = { ... } }`. See https://grafana.com/docs/grafana/latest/auth/overview/ for a complete list of possible properties for each provider."
  default     = {}
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

variable "datasources" {
  description = "List of data sources to put into Grafana. See https://grafana.com/docs/grafana/latest/administration/provisioning/#datasources for examples."
  default     = []
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

variable "wait" {
  description = "Whether to wait for the deployment of this helm chart to succeed before completing."
  default     = true
}

variable "database_auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = false
}

variable "chart_values" {
  default = {}
}
