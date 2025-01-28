data "azurerm_marketplace_agreement" "fortinet1" {
  publisher = "fortinet"
  offer     = "fortinet_fortigate-vm_v5"
  plan      = "fortinet_fg-vm_payg_2023"
}

  
output "marketplace_agreement1" {
  value = data.azurerm_marketplace_agreement.fortinet1
}


data "azurerm_marketplace_agreement" "fortinet2" {
  publisher = "fortinet"
  offer     = "fortinet_fortigate-vm_v5"
  plan      = "fortinet_fg-vm"
}

output "marketplace_agreement2" {
  value = data.azurerm_marketplace_agreement.fortinet2
}
