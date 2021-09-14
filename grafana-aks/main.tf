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
  resource_name = random_id.resource_name.hex

  # Administrator login must start with a letter, so it is
  # generated from two parts - a leading letter and an alphanumeric part:
  administrator_login = "${random_password.dbuser_first.result}${random_password.dbuser_rest.result}"
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

  prefix      = "grafana"
  byte_length = 8
}

resource "random_password" "dbpass" {
  length  = 16
  special = false
}

resource "random_password" "dbuser_first" {
  length  = 1
  special = false
  number  = false
}

resource "random_password" "dbuser_rest" {
  length  = 15
  special = false
}


resource "azurerm_postgresql_flexible_server" "this" {
  name                = local.resource_name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location

  version = "12"

  administrator_login    = local.administrator_login
  administrator_password = random_password.dbpass.result

  sku_name = "B_Standard_B1ms"

  storage_mb = 32768
}

data "azurerm_public_ip" "external_ips" {
  for_each = toset([for i in var.cluster_outbound_ips : split("/", i)[8]])

  name                = each.value
  resource_group_name = data.azurerm_kubernetes_cluster.this.node_resource_group
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "this" {
  for_each = data.azurerm_public_ip.external_ips

  name      = local.resource_name
  server_id = azurerm_postgresql_flexible_server.this.id

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
  database_host               = azurerm_postgresql_flexible_server.this.fqdn
  database_port               = 5432
  database_user               = local.administrator_login
  database_password           = random_password.dbpass.result
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
