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

resource "azurerm_storage_container" "web" {
  name                  = "$web"
  storage_account_name  = var.storage_account
  container_access_type = "blob"
}

resource "azurerm_cdn_endpoint" "ui" {
  name                = "boundlexx-ui"
  profile_name        = var.cdn_profile
  location            = "Global"
  resource_group_name = var.resource_group
  is_http_allowed = true
  is_https_allowed = true
  is_compression_enabled = true
  content_types_to_compress = var.compress_types
  querystring_caching_behaviour = "IgnoreQueryString"
  optimization_type = "GeneralWebDelivery"
  origin_host_header = var.storage_web_host

  origin {
    name      = "boundlexx-ui"
    host_name = var.storage_web_host
  }

  global_delivery_rule {
      cache_expiration_action {
          behavior = "Override"
          duration = "30.00:00:00"
      }
  }

  delivery_rule {
    name = "HTTPRedirect"
    order = 1

    request_scheme_condition {
      operator = "Equal"
      match_values = ["HTTP"]
    }

    url_redirect_action {
      redirect_type = "PermanentRedirect"
      protocol = "Https"
    }
  }

  delivery_rule {
    name = "NoCacheServiceWorker"
    order = 2

    url_path_condition {
      operator = "BeginsWith"
      match_values = ["/service-worker.js"]
    }

    cache_expiration_action {
      behavior = "BypassCache"
    }
  }

  delivery_rule {
    name = "NoCacheUpdates"
    order = 3

    url_path_condition {
      operator = "BeginsWith"
      match_values = ["/updates.json"]
    }

    cache_expiration_action {
      behavior = "BypassCache"
    }
  }

  delivery_rule {
    name = "NoCacheIndex"
    order = 4

    url_path_condition {
      operator = "BeginsWith"
      match_values = ["/index.html"]
    }

    cache_expiration_action {
      behavior = "BypassCache"
    }
  }

  delivery_rule {
    name = "ReactRoutes"
    order = 5

    url_file_extension_condition {
      operator = "GreaterThan"
      negate_condition = true
      match_values = [0]
    }

    url_rewrite_action {
      source_pattern = "/"
      destination = "/index.html"
      preserve_unmatched_path = false
    }
  }
}

resource "cloudflare_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  value   = azurerm_cdn_endpoint.ui.host_name
  type    = "CNAME"
}
