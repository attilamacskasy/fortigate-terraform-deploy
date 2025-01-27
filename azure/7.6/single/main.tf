// Resource Group

resource "azurerm_resource_group" "myterraformgroup" {
  //name     = "terraform-single-fgt"
  // due to delays in Azure API, its better to redeploy using a new RG name. probably adding a random number to rg name will do a better job :)
  // when changeing location from westus2 to westeurope (or the other way around), huge dealys in destroy.... 
  // well, need to check if marketplace item is available for a region or not before running this
  name     = "tf-single-fgt-001"
  location = var.location

  tags = {
    environment = "Terraform Single FortiGate"
  }
}

// Marketplace agreement.
resource "azurerm_marketplace_agreement" "fortinet" {
  //count     = var.accept ? 1 : 0
  publisher = var.publisher
  offer     = var.fgtoffer
  plan      = var.fgtsku[var.arch][var.license_type]

/*
  publisher = "fortinet"
  offer     = "fortinet_fortigate-vm_v5"
  plan      = "fortinet_fg-vm_payg_2023"
*/
}
