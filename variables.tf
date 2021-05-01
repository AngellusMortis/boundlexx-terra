variable "boundlexx_domain" {
    description = "Base Boundlexx Domain"
    type = string
    default = "boundlexx.app"
}

variable "metabase_ip" {
    description = "Metabase IP address"
    type = string
}

variable "azure_subscription_id" {
    description = "Azure Subscription ID"
    type = string
}

variable "cloudflare_api_token" {
    description = "Cloudflare API Token"
    type = string
}

variable "compress_types" {
  description = "MIME types to compress for CDN"
  type = list(string)
  default = [
      "application/eot",
      "application/font",
      "application/font-sfnt",
      "application/javascript",
      "application/json",
      "application/opentype",
      "application/otf",
      "application/pkcs7-mime",
      "application/truetype",
      "application/ttf",
      "application/vnd.ms-fontobject",
      "application/xhtml+xml",
      "application/xml",
      "application/xml+rss",
      "application/x-font-opentype",
      "application/x-font-truetype",
      "application/x-font-ttf",
      "application/x-httpd-cgi",
      "application/x-javascript",
      "application/x-mpegurl",
      "application/x-opentype",
      "application/x-otf",
      "application/x-perl",
      "application/x-ttf",
      "font/eot",
      "font/ttf",
      "font/otf",
      "font/opentype",
      "image/svg+xml",
      "text/css",
      "text/csv",
      "text/html",
      "text/javascript",
      "text/js",
      "text/plain",
      "text/richtext",
      "text/tab-separated-values",
      "text/xml",
      "text/x-script",
      "text/x-component",
      "text/x-java-source",
    ]
}
