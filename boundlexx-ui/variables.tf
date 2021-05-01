variable "cloudflare_api_token" {
    description = "Cloudflare API Token"
    type = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type = string
}

variable "resource_group" {
  description = "Azure resource group name"
  type = string
}

variable "storage_account" {
  description = "Azure stroage account name"
  type = string
}

variable "storage_web_host" {
  description = "Azure stroage account primary web URL"
  type = string
}

variable "cdn_profile" {
  description = "Azure CDN profile name"
  type = string
}

variable "compress_types" {
  description = "MIME types to compress for CDN"
  type = list(string)
}

