# Using Terraform modules to deploy Grafana to cloud
### Acceptance criterias:
- [AWS Grafana link](http://54.93.163.55:3000)
- [Azure Grafana link](http://40.69.210.96:3000)
- Screenshot

![image](https://user-images.githubusercontent.com/109740456/209736566-3bf8bcda-31b8-4479-b187-4497499640ee.png)


>NOTE: Terraform version im using is  v1.3.6
### FOREWORD ###
Hi there!
In this repo i'd like to describe using [Terraform](https://www.terraform.io/) with creating reusable modules for deploying to cloud.

A module is a container for multiple resources that are used together. You can use modules to create lightweight abstractions, so that you can describe your infrastructure in terms of its architecture, rather than directly in terms of physical objects.

### MAIN IDEA ###
As a best practice for none-lab projects i recommend using special file structure where several environments (dev test prod etc.) will be defined, so u can easy manage infrastructure in understandable directory list.

I took main idea from Gruntwork blog by Yevgeniy Brikman [here](https://blog.gruntwork.io/how-to-create-reusable-infrastructure-with-terraform-modules-25526d65f73d), so read more about it if you want.

Here i pictured filestructure for this project for better understanding what is going on:
 
```
live/
└── prod/
      └── grafana/
            |── main.tf(here the args are inserted to the child modules)
            ├── outputs.tf(here are references to the child module outputs)
            └── providrs.tf(here the proiders in use are declared)
modules/
│── aws/
|     └── services/
|           └── grafana-standalone/
|                 |── vms.tf --> declaring vm configuration 
|                 |── variables.tf --> declaring input variables
|                 ├── security-groups.tf --> declaring firewall rules
|                 |── networking.tf --> declaring network configuration
|                 |── outputs.tf --> formated output for using in root module while calling the submodule
|                 └── metadata/
|                       └── grafana-spray.sh --> metadata script will be used while booting for deploying grafana app
└── azure/
      └── services/
            └── grafana-standalone/
                  |── virtualmachines.tf --> declaring vm configuration
                  |── variables.tf --> declaring input variables
                  ├── nsg.tf --> declaring firewall rules
                  |── networking.tf --> declaring network configuration
                  |── outputs.tf --> formated output for using in root module while calling the submodule
                  └── metadata/
                        └── grafana-spray.sh --> metadata script will be used while booting for deploying grafana app
```
U can create additional directories for:
  - wide collection of modules by adding new _service_ directory to _services_
  - additional environments by adding new _environment_ code directory to _live_ directory
  
### ABOUT PROJECT REQUIRENMENTS ###
This project is built for creating infra in Azure and AWS clouds by doing simple configuration and running _apply_.
Child modules are refered in root module _main.tf_ file
You can see useful outputs while running terraform
### REQUIRENMENTS ###
For running this project locally you will need (follow links if need some of those):
  - Linux machine or VM(u can use [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) if using Windows)
  - [SSH key pair](https://www.ssh.com/academy/ssh/keygen)
  - Terraform [installed](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
  - [AWS account](https://portal.aws.amazon.com/billing/signup#/start/email) with free tier or credit on it
  - [Azure cloud account](https://azure.microsoft.com/en-us/free/) with free tier or credit on it
  - Credentials for providing Terraform with:
    - [AWS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret)
    - [Azure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
    
Configuring:
  - Change input variables in _terraform-modules/live/prod/grafana/main.tf_ file if u need
  - Make sure u're using your own SSH-key pair by providing SSh-key path in _terraform-modules/live/prod/grafana/main.tf_:
  ```
  ssh_key_path       = "<change-me>" #for aws
  admin_ssh_key_path = "<change-me>" #for azure
  ```
  - Rewrite or change the _metadata_ drectory script for changing VM bootstrap config
  
### HOW TO USE ? ###
After u have all the files locally and configured, run next commands:

Initialize Terraform
```
terraform init
```
Validate the code
```
terraform validate
```
Plan the execution
```
terraform plan
```
If everything is ok apply changes
```
terraform apply
```
> NOTE! pass "yes" in dialog to confirm creation

Or use autoapprove
```
terraform apply --auto-approve
```
Destroy infrastructure if u need
```
terraform destroy
```
> NOTE! pass "yes" in dialog to confirm deletion

Or use autoapprove
```
terraform destroy --auto-approve
```
Usefull commands:
To format your code
```
terraform fmt
```
To show outputs
```
terraform outputs
```
### OUTRO ###
Hope u enjoyed seeing my project!

Feel free to use it and share your oppinion about the code!
