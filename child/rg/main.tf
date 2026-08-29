variable "rgsd" {}
resource "azurerm_resource_group" "rgs" {
  for_each = var.rgsd
  name     = each.value.name
  location = each.value.location
}