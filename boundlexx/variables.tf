variable "prefix" {
  description = "Prefix for creating accounts"
  type = string
  default = ""
}

variable "subdomain" {
  description = "App subdomain"
  type = string
  default = "api"
}

variable "storage_account" {
  description = "Azure stroage account"
  type = string
}

variable "boundlexx_domain" {
  description = "Base Boundlexx Domain"
  type = string
}

variable "origin_base" {
  description = "Base Origin Domain"
  type = string
  default = "boundlexx.wl.mort.is"
}

variable "resource_group" {
  description = "Azure resource group name"
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

variable "cloudflare_api_token" {
    description = "Cloudflare API Token"
    type = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type = string
}
