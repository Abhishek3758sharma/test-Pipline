module "rgs" {
  source = "../child/rg"
  rgsd   = var.rgs_value
}
module "vnet" {
  source     = "../child/vnet"
  vnetd      = var.vnet_value
  depends_on = [module.rgs]
}
module "snet" {
  source     = "../child/snet"
  snetd      = var.snet_value
  depends_on = [module.vnet]
}
module "pip" {
  source     = "../child/pip"
  pips       = var.pip_value
  depends_on = [module.snet]

}
module "vm" {
  source     = "../child/vm"
  vm         = var.vm_value
  depends_on = [module.pip]
}