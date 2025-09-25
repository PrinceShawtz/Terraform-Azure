resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  vnet_name           = "${var.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  subnet_name         = "${var.prefix}-subnet"
  subnet_prefix       = "10.0.1.0/24"
  tags                = var.tags
}

module "nsg" {
  source              = "./modules/nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  name                = "${var.prefix}-nsg"
  security_rules      = var.security_rules
  tags                = var.tags
}

# Associate NSG to subnet (explicit resource)
resource "azurerm_subnet_network_security_group_association" "assoc" {
  subnet_id                 = module.network.subnet_id
  network_security_group_id = module.nsg.nsg_id
}

module "vm" {
  source              = "./modules/compute"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  vm_name             = "${var.prefix}-vm"
  subnet_id           = module.network.subnet_id
  admin_username      = var.admin_username
  admin_ssh_public_key = file(var.ssh_pub_key_path)
  vm_size             = var.vm_size
  tags                = var.tags
}

