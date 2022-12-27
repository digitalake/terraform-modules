#Vm ip
output "azure_vm_grafana_pub_endpoint" {
  value = "Hey! Go and check deployed Grafana on Azure by link: http://${azurerm_public_ip.gl-vm-pub-ip.ip_address}:3000"
}

output "azure_vm_connect_via_ssh" {
  value = "Access via ssh using command: ssh -i <deploy-key-path> suser@${azurerm_public_ip.gl-vm-pub-ip.ip_address}"
}