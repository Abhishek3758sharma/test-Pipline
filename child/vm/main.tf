variable "vm" {}
data "azurerm_subnet" "snet" {
    for_each = var.vm
  name                 = each.value.snet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
data "azurerm_public_ip" "pips" {
    for_each = var.vm
  name                = each.value.pips_name
  resource_group_name = each.value.resource_group_name
}
resource "azurerm_network_interface" "example" {
    for_each = var.vm
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.ip_conf_name
    subnet_id                     = data.azurerm_subnet.snet[each.key].id
    public_ip_address_id          = data.azurerm_public_ip.pips[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "linux_vm" {
    for_each = var.vm
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password = each.value.admin_password
  disable_password_authentication = false
  network_interface_ids = [
    #EMPLICIT DEPENDENCY LAGAYA GAYA HAI KYU KI PHALE NIC BANE GA USKE BAAD VM
    azurerm_network_interface.example[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}