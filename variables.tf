variable "prefix" { type = string default = "tfdemo" }
variable "location" { type = string default = "eastus" }
variable "resource_group_name" { type = string default = "tfdemo-rg" }
variable "admin_username" { type = string default = "azureuser" }
variable "ssh_pub_key_path" { type = string default = "~/.ssh/id_rsa.pub" }
variable "vm_size" { type = string default = "Standard_B1s" }
variable "tags" {
  type = map(string)
  default = {
    Env      = "Dev"
    costPlan = "1y"
    Owner    = "Terraform"
  }
}
# Security rules: list of maps (name, priority, direction, access, protocol, source_port_range, destination_port_range, optional source/dest prefixes)
variable "security_rules" {
  type = list(map(any))
  default = [
    {
      name                    = "allow_ssh"
      priority                = 100
      direction               = "Inbound"
      access                  = "Allow"
      protocol                = "Tcp"
      source_port_range       = "*"
      destination_port_range  = "22"
      source_address_prefix   = "*"
      destination_address_prefix = "*"
    },
    {
      name                    = "allow_http"
      priority                = 200
      direction               = "Inbound"
      access                  = "Allow"
      protocol                = "Tcp"
      source_port_range       = "*"
      destination_port_range  = "80"
      source_address_prefix   = "*"
      destination_address_prefix = "*"
    },
    {
      name                    = "allow_https"
      priority                = 300
      direction               = "Inbound"
      access                  = "Allow"
      protocol                = "Tcp"
      source_port_range       = "*"
      destination_port_range  = "443"
      source_address_prefix   = "*"
      destination_address_prefix = "*"
    }
  ]
}

