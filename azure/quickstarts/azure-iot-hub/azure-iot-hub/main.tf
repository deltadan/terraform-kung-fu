# #################################################################################
# Build5Nines: Terraform Kung-fu
# https://build5nines.com/teraform-kung-fu
# Copyright (c) 2020 Build5Nines.com
# MIT License - https://github.com/Build5Nines/terraform-kung-fu/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - Create an Azure IoT Hub within a Resource Group
# #################################################################################
# USAGE:
# - Update the local variables to configure the resource
# #################################################################################
# HELPFUL RESOURCES:
# - https://build5nines.com/terraform-create-azure-iot-hub-and-dps/
# #################################################################################

provider "azurerm" {
  # AzureRM provider 2.x
  version = "~>2.0"
  # v2.x required "features" block
  features {}
}

locals {
    resource_group_name = "b59_iot"
    location            = "westus"
    
    iot_hub_name        = "b59_iot_hub"
    iot_hub_sku         = "S1"
    iot_hub_capacity    = 1
}

# Create a resource group
resource "azurerm_resource_group" "primary" {
  name     = local.resource_group_name
  location = local.location
}

# Create an Azure IoT Hub
resource "azurerm_iothub" "primary" {
    name                = local.iot_hub_name
    resource_group_name = azurerm_resource_group.primary.name
    location            = azurerm_resource_group.primary.location

    sku {
        name     = local.iot_hub_sku
        capacity = local.iot_hub_capacity
    }
}