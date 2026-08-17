rgs_value = {
  rg1 = {
    name     = "Rg-load"
    location = "centralindia"
  }
}
vnet_value = {
  vnet = {
    name                = "vnet-Load"
    location            = "centralindia"
    resource_group_name = "Rg-load"
    address_space       = ["10.0.0.0/16"]
  }
}
snet_value = {
  snet1 = {
    name                 = "snet_frontend"
    resource_group_name  = "Rg-load"
    virtual_network_name = "vnet-Load"
    address_prefixes     = ["10.0.1.0/24"]
  }
  snet2 = {
    name                 = "snet_backend"
    resource_group_name  = "Rg-load"
    virtual_network_name = "vnet-Load"
    address_prefixes     = ["10.0.2.0/24"]
  }
}
pip_value = {
  pip1 = {
    name                = "pip_frontend"
    resource_group_name = "Rg-load"
    location            = "centralindia"
    allocation_method   = "Static"
  }
  pip2 = {
    name                = "pip_backend"
    resource_group_name = "Rg-load"
    location            = "centralindia"
    allocation_method   = "Static"
  }
}
vm_value = {
  vm1 = {
    virtual_network_name = "vnet-Load"
    snet_name            = "snet_frontend"
    pips_name            = "pip_frontend"
    nic_name             = "forntend_nic"
    location             = "centralindia"
    resource_group_name  = "Rg-load"
    ip_conf_name         = "internal"
    vm_name              = "forntend-vm"
    size                 = "Standard_D2s_v3"
    admin_username       = "Frontend"
    admin_password       = "Frontend1234"

  }
  vm2 = {
    virtual_network_name = "vnet-Load"
    snet_name            = "snet_backend"
    pips_name            = "pip_backend"
    nic_name             = "backend_nic"
    location             = "centralindia"
    resource_group_name  = "Rg-load"
    ip_conf_name         = "internal"
    vm_name              = "backend-vm"
    size                 = "Standard_D2s_v3"
    admin_username       = "backend"
    admin_password       = "Backend1234"

  }
}