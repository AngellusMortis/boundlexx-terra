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
