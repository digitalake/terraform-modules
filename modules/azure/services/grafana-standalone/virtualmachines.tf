#Create Linux Virtual Machines Workloads
resource "azurerm_linux_virtual_machine" "linux-vm" {

  name                  = "${var.vmname}linuxvm"
  location              = azurerm_resource_group.gl-resource-group.location
  resource_group_name   = azurerm_resource_group.gl-resource-group.name
  network_interface_ids  = ["${azurerm_network_interface.webapp.id}"]
  size                  = "Standard_B1s" # "Standard_D2ads_v5" # "Standard_DC1ds_v3" "Standard_D2s_v3"


  #Create Operating System Disk
  os_disk {
    name                 = "${var.vmname}disk"
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type #Consider Storage Type
  }


  #Reference Source Image from Publisher
  source_image_reference {
    publisher = "Canonical"                    #az vm image list -p "Canonical" --output table
    offer     = "0001-com-ubuntu-server-focal" # az vm image list -p "Canonical" --output table
    sku       = "20_04-lts-gen2"               #az vm image list -s "20.04-LTS" --output table
    version   = "latest"
  }


  #Create Computer Name and Specify Administrative User Credentials
  computer_name                   = "linux-vm"
  admin_username                  = "suser"
  disable_password_authentication = true



  #Create SSH Key for Secured Authentication 
  admin_ssh_key {
    username   = "suser"
    public_key = file("${var.admin_ssh_key_path}")
  }

  #Deploy Custom Data on Hosts
  custom_data = "${filebase64("${path.module}/metadata/grafana-spray.sh")}"

}