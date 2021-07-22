terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.68"
    }
  }
}

locals {
  namespace     = var.namespace
  release_name  = var.release_name
  resource_name = "grafana${random_id.resource_name.dec}"
}

data "azurerm_resource_group" "this" {
  name = var.resource_group
}

data "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "random_id" "resource_name" {
  keepers = {
    release_name = local.release_name
  }

  byte_length = 10
}

resource "random_password" "dbpass" {
  length  = 16
  special = false
}

resource "random_password" "dbuser" {
  length  = 16
  special = false
}

resource "azurerm_postgresql_server" "this" {
  name                = local.resource_name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location

  version = "11"

  administrator_login          = random_password.dbuser.result
  administrator_login_password = random_password.dbpass.result

  sku_name   = "B_Gen5_1"
  storage_mb = 5120

  backup_retention_days = 7
  auto_grow_enabled     = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_postgresql_database" "this" {
  name                = "grafana"
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = azurerm_postgresql_server.this.name
  charset             = "UTF8"
  collation           = "en_US"
}

data "azurerm_subnet" "example" {
  name                 = "backend"
  virtual_network_name = "production"
  resource_group_name  = "networking"
}

data "azurerm_public_ip" "external_ips" {
  for_each = flatten(data.azurerm_kubernetes_cluster.this.network_profile[*].load_balancer_profile[*].effective_outbound_ips)

  name                = each.value
  resource_group_name = data.azurerm_kubernetes_cluster.this.node_resource_group
}

resource "azurerm_postgresql_firewall_rule" "this" {
  for_each = data.azurerm_public_ip.external_ips

  name                = local.resource_name
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = azurerm_postgresql_server.this.name

  start_ip_address = each.value.ip_address
  end_ip_address   = each.value.ip_address
}

resource "azurerm_storage_account" "this" {
  name                     = local.resource_name
  resource_group_name      = data.azurerm_resource_group.this.name
  location                 = data.azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "this" {
  name                  = local.resource_name
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}

module "grafana" {
  source = "../grafana"

  namespace                   = local.namespace
  release_name                = local.release_name
  database_host               = azurerm_postgresql_server.this.fqdn
  database_port               = 5432
  database_password           = random_password.dbpass.result
  database_user               = random_password.dbuser.result
  external_image_storage_type = "azure_blob"
  external_image_storage = {
    account_name   = local.resource_name
    container_name = local.resource_name
    account_key    = azurerm_storage_account.this.primary_access_key
  }
  oauth_config            = var.oauth_config
  datasources             = var.datasources
  auth_disable_login_form = var.auth_disable_login_form
  ingress_cluster_issuer  = var.ingress_cluster_issuer
  root_domain             = var.root_domain
  ingress_enabled         = var.ingress_enabled
  ingress_hostnames       = var.ingress_hostnames
}
