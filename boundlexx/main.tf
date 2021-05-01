terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 2.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "azurerm_storage_container" "atlas" {
  name                  = "${var.prefix}atlas"
  storage_account_name  = var.storage_account
  container_access_type = "blob"
}

resource "azurerm_storage_container" "emoji" {
  name                  = "${var.prefix}emoji"
  storage_account_name  = var.storage_account
  container_access_type = "blob"
}

resource "azurerm_storage_container" "exports" {
  name                  = "${var.prefix}exports"
  storage_account_name  = var.storage_account
  container_access_type = "blob"
}

resource "azurerm_storage_container" "images" {
  name                  = "${var.prefix}images"
  storage_account_name  = var.storage_account
  container_access_type = "blob"
}

resource "azurerm_storage_container" "items" {
  name                  = "${var.prefix}items"
  storage_account_name  = var.storage_account
  container_access_type = "blob"
}

resource "azurerm_storage_container" "logos" {
  name                  = "${var.prefix}logos"
  storage_account_name  = var.storage_account
  container_access_type = "blob"
}

resource "azurerm_storage_container" "skills" {
  name                  = "${var.prefix}skills"
  storage_account_name  = var.storage_account
  container_access_type = "blob"
}

resource "azurerm_storage_container" "worlds" {
  name                  = "${var.prefix}worlds"
  storage_account_name  = var.storage_account
  container_access_type = "blob"
}

resource "azurerm_cdn_endpoint" "web" {
  name                = "boundlexx-app-${var.subdomain}"
  profile_name        = var.cdn_profile
  location            = "Global"
  resource_group_name = var.resource_group
  is_http_allowed = false
  is_https_allowed = true
  querystring_caching_behaviour = "NotSet"
  optimization_type = "GeneralWebDelivery"
  origin_host_header = "${var.subdomain}.${var.boundlexx_domain}"

  origin {
    name      = "boundlexx-app"
    host_name = "${var.prefix}${var.origin_base}"
  }
}

resource "cloudflare_record" "app" {
  zone_id = var.cloudflare_zone_id
  name    = var.subdomain
  value   = azurerm_cdn_endpoint.web.host_name
  type    = "CNAME"
}
