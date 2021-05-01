terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }

    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 2.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_zone" "boundlexx" {
    zone = "boundlexx.app"
}

resource "cloudflare_zone_dnssec" "boundlexx" {
    zone_id = cloudflare_zone.boundlexx.id
}

resource "azurerm_resource_group" "rg" {
  name     = "boundlexx-resource-group"
  location = "eastus"
}

resource "azurerm_storage_account" "static" {
  name                     = "boundlexxstaticfiles"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
  access_tier = "Hot"
  allow_blob_public_access = true
}

resource "azurerm_cdn_profile" "static" {
  name                = "boundlexx-static-cdn"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "static" {
  name                = "boundlexx-static"
  profile_name        = azurerm_cdn_profile.static.name
  location            = "Global"
  resource_group_name = azurerm_resource_group.rg.name
  is_http_allowed = true
  is_https_allowed = true
  is_compression_enabled = true
  content_types_to_compress = var.compress_types
  querystring_caching_behaviour = "IgnoreQueryString"
  optimization_type = "GeneralWebDelivery"
  origin_host_header = azurerm_storage_account.static.primary_blob_host

  origin {
    name      = "boundlexx-app"
    host_name = azurerm_storage_account.static.primary_blob_host
  }

  global_delivery_rule {
      cache_expiration_action {
          behavior = "Override"
          duration = "01:00:00"
      }
  }
}

# resource "cloudflare_record" "root" {
#   zone_id = cloudflare_zone.boundlexx.id
#   name    = var.boundlexx_domain
#   value   = azurerm_storage_account.static.primary_blob_host
#   type    = "CNAME"
# }

resource "cloudflare_record" "metabase" {
  zone_id = cloudflare_zone.boundlexx.id
  name    = "metabase"
  value   = var.metabase_ip
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "cdn" {
  zone_id = cloudflare_zone.boundlexx.id
  name    = "cdn"
  value   = azurerm_cdn_endpoint.static.host_name
  type    = "CNAME"
}

module env_local {
  source = "./boundlexx"
  prefix = "local-"
  storage_account = azurerm_storage_account.static.name
}

module env_testing {
  source = "./boundlexx"
  prefix = "testing-"
  storage_account = azurerm_storage_account.static.name
}

module env_live {
  source = "./boundlexx"
  prefix = ""
  storage_account = azurerm_storage_account.static.name
}

module boundlexx_ui {
  source = "./boundlexx-ui"
  resource_group = azurerm_resource_group.rg.name
  storage_account = azurerm_storage_account.static.name
  cdn_profile = azurerm_cdn_profile.static.name
  storage_web_host = azurerm_storage_account.static.primary_web_host
  compress_types = var.compress_types
  cloudflare_zone_id = cloudflare_zone.boundlexx.id
  cloudflare_api_token = var.cloudflare_api_token
}
