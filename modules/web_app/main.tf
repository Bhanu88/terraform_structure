resource "azurerm_app_service_plan" "main" {
  name                = "${var.prefix}-asp"
  location            = "${var.location}"
  resource_group_name = "${var.rg}"

  sku {
    tier = "PremiumV2"
    size = "P2v2"
    capacity = "1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "${var.prefix}-appservice"
  location            = "${var.location}"
  resource_group_name = "${var.rg}"
  app_service_plan_id = "${azurerm_app_service_plan.main.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    remote_debugging_enabled = true
    remote_debugging_version = "VS2019"
    http2_enabled = true
    cors {
      allowed_origins = ["*"]
    }
  }
  
}
