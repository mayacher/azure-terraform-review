# terraform-azure
manual steps:   
create remote state backend:  
https://dev.to/cloudskills/getting-started-with-terraform-on-azure-remote-state-2d5c#:~:text=Remote%20state%20allows%20Terraform%20to,storage%20solution%20in%20Terraform%20Cloud.  
https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage  
creating a resource group and container to support tfstate storing on container blob through cli  
```
 az group create --location northeurope --name rg-storagestate  
 az storage account create --name mayadevopsstorage --resource-group rg-storagestate --location northeurope --sku Standard_LRS --encryption-services blob --default-action Allow  
 ACCOUNT_KEY=$(az storage account keys list --resource-group rg-storagestate  --account-name mayadevopsstorage --query '[0].value' -o tsv)  
 az storage container create -n terraformdemo  -account-name mayadevopsstorage --account-key $ACCOUNT_KEY  
```
  
 Terraform  
 dir modules >  
   variables.tf > define variables to easily convert working with module  
   main.tf > creating infrastructure for azure  
   aks.tf  > creating aks resources and container registry  
   outputs.tf > output kubeconfig and more data  

 dir config >  
   deploy.tf > using a remote state in container in azure  
               import the module dir and set the relevant vars  
   outputs.tf > to export data such as kubeconfig and debug  


