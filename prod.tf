variable "client_secret" {
}

variable "env_prefix" {
}

variable "env_subscription" {
}

variable "location" {
}


provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.46.0"

  subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  client_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  client_secret   = var.client_secret
  tenant_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "xxxxxxxxxx"
    container_name       = "xxxxxxx"
    key                  = "terraform.tfstate"
    access_key           = "xxxxxxxxxxxxx"
  }
}

# Create a resource group
resource "azurerm_resource_group" "mbvrg" {
  name     = "${var.env_prefix}-${var.env_subscription}-rg"
  location = "${var.location}"
}

#app service 
module "web_app" {
  source = "./modules/web_app"

  rg       = azurerm_resource_group.mbvrg.name
  location = azurerm_resource_group.mbvrg.location
  prefix   = var.env_prefix
}

output "app_service_name" {
  value = "${module.web_app.app_service_name}"
}

output "app_service_default_hostname" {
  value = "${module.web_app.app_service_default_hostname}"
}

