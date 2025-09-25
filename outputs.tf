output "vm_private_ip" {
  description = "Private IP of the VM"
  value       = module.vm.private_ip
}

output "vm_public_ip" {
  description = "Public IP (useful for Ansible SSH)."
  value       = module.vm.public_ip
}

output "vnet_id" {
  description = "ID of the VNet"
  value       = module.network.vnet_id
}
