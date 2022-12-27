module "grafana_standalone-aws" {
  source             = "../../../modules/aws/services/grafana-standalone"
  region             = "eu-central-1"
  aws_az             = "eu-central-1a"
  vpc_cidr           = "10.10.20.0/26"
  public_subnet_cidr = "10.10.20.0/28"
  ssh_key_path       = "~/.ssh/deploy.pub"
  vm_instance_type   = "t2.micro"
  vm-ami             = "ami-0af6bb52ea735ac55"
  #Define own variables here
}

module "grafana_standalone-azure" {
  source                = "../../../modules/azure/services/grafana-standalone"
  avzs                  = ["North Europe", "West Europe"]
  vnet_addr_spc         = ["10.20.0.0/16"]
  subnet_pref           = ["10.20.10.0/24"]
  vmname                = "gl-linux"
  web_access_port_range = ["22", "3000"]
  admin_ssh_key_path    = "~/.ssh/deploy.pub"
  storage_account_type  = "Standard_LRS"
  #Define own variables here
}