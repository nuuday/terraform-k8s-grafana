variable "chart_version" {
  default     = "6.20.6"
  description = "Grafana version to install"
  type        = string
}

variable "database_user" {
  description = "RDS Database username"
  type        = string
}

variable "database_password" {
  description = "RDS Database password"
  type        = string
}

variable "database_port" {
  description = "RDS Database port"
  type        = string
}

variable "database_host" {
  description = "RDS Database host"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace to deploy to. This will fail if the namespace already exists."
  type        = string
}

variable "release_name" {
  description = "Helm release name"
  type        = string
}

variable "oauth_config" {
  description = "OAuth configuration map for grafana.ini. E.g. `{ auth.github = { ... } }`. See https://grafana.com/docs/grafana/latest/auth/overview/ for a complete list of possible properties for each provider."
  default     = {}
}

variable "external_image_storage_type" {
  description = "Type of external image storage, i.e. `s3` or `azure_blob`"
  default     = "s3"
}

variable "external_image_storage" {
  description = "Grafana config snippet for external_image_storage: https://grafana.com/docs/grafana/latest/administration/configuration/#external_image_storage"
  type        = map(string)
}

variable "config_secrets" {
  description = "Addition configuration parameters that should be passed as a secret"
  type        = map(string)
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

variable "ingress_read_timeout" {
  type        = number
  default     = 300
  description = "Read timeout of ingress, intentionally set high to be able to proxy heavy queries"
}

variable "wait" {
  description = "Whether to wait for the deployment of this helm chart to succeed before completing."
  default     = true
}

variable "chart_values" {
  default = {}
}

variable "eks_iam_role_arn" {
  description = "IAM Role ARN with which to annotate SA"
  type        = string
  default     = null
}

variable "plugins" {
  description = "Plugins in addition to the default ones"
  type        = list(string)
  default     = []
}
