# USAGE

- Used to create a VNet with subnets. 
- Create Subnet with their route table.
- To store the ***.tfstate*** file in provisioned cloud backend edit ***backend.tf***.
- To apply change the name of ***vnet.tfvars.reference*** to ***vnet.tfvars*** and enter ***region*** and ***resources-group***.

- To apply  :

        cd azure/02-vnet
        terraform init
        terraform plan -var-file=vars/vnet.tfvars -out plan.out   
        terraform apply plan.out

- To destroy the resources:

      terraform destroy -var-file=vars/vnet.tfvars