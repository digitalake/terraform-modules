output "aws_public_endpoint" {
  value = module.grafana_standalone-aws.aws_vm_grafana_pub_endpoint
}

output "aws_ssh_connection" {
  value = module.grafana_standalone-aws.aws_vm_connect_via_ssh

}

output "azure_public_endpoint" {
  value = module.grafana_standalone-azure.azure_vm_grafana_pub_endpoint
}

output "azure_ssh_connection" {
  value = module.grafana_standalone-azure.azure_vm_connect_via_ssh
}