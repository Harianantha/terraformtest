provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=1.44.0"
  subscription_id = "3969c68b-836d-41c8-9f4e-27db41ca4029"
}

resource "azurerm_resource_group" "Demo" {
  name     = "familytech"
  location = "Central India"
}

resource "azurerm_storage_account" "Demo" {
  name                     = "iyerdemostorage"
  resource_group_name      = azurerm_resource_group.Demo.name
  location                 = azurerm_resource_group.Demo.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}