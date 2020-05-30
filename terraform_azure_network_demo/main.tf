provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=1.44.0"
  subscription_id = "3969c68b-836d-41c8-9f4e-27db41ca4029"
}

resource "azurerm_resource_group" "Demo" {
  name     = "familytech"
  location = "Central India"
}


resource "azurerm_network_security_group" "Demo" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.Demo.location
  resource_group_name = azurerm_resource_group.Demo.name
}

resource "azurerm_network_ddos_protection_plan" "Demo" {
  name                = "ddospplan1"
  location            = azurerm_resource_group.Demo.location
  resource_group_name = azurerm_resource_group.Demo.name
}

resource "azurerm_virtual_network" "Demo" {
  name                = "virtualNetwork1"
  location            = azurerm_resource_group.Demo.location
  resource_group_name = azurerm_resource_group.Demo.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.Demo.id
    enable = true
  }

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
    security_group = azurerm_network_security_group.Demo.id
  }

  tags = {
    environment = "Production"
  }
}