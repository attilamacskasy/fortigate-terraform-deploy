// Azure configuration
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

// x86 - Standard_F4s_v2
// arm - Standard_D2ps_v5
variable "size" {
  type    = string
  //default = "Standard_F4s_v2"
  //changed due to limitations in FortiGate EVAL (Maximum of 1 CPU and 2 GB of memory) https://docs.fortinet.com/document/fortigate/7.4.7/administration-guide/441460 
  default = "Standard_B1s"
}

// To use custom image
// by default is false
variable "custom" {
  default = false
}

//  Custom image blob uri
variable "customuri" {
  type    = string
  default = "<custom image blob uri>"
}

variable "custom_image_name" {
  type    = string
  default = "<custom image name>"
}

variable "custom_image_resource_group_name" {
  type    = string
  default = "<custom image resource group>"
}

// To accept marketplace agreement
// Default is false
variable "accept" {
  //default = "false"
  default = "true"
}

// License Type to create FortiGate-VM
// Provide the license type for FortiGate-VM Instances, either byol or payg.
variable "license_type" {
  default = "payg"
  //default = "byol"
}

// instance architect
// Either arm or x86
variable "arch" {
  default = "x86"
}

// BYOL License format to create FortiGate-VM
// Provide the license type for FortiGate-VM Instances, either token or file.
variable "license_format" {
  default = "token"
}

variable "publisher" {
  type    = string
  default = "fortinet"
}

variable "fgtoffer" {
  type    = string
  default = "fortinet_fortigate-vm_v5"
}

// x86
// BYOL sku: fortinet_fg-vm_g2
// PAYG sku: fortinet_fg-vm_payg_2023_g2
// arm
// BYOL sku: fortinet_fg-vm_arm64
// PAYG sku: fortinet_fg-vm_payg_2023_arm64
variable "fgtsku" {
  type = map(any)
  default = {
    x86 = {
      byol = "fortinet_fg-vm_g2"
      payg = "fortinet_fg-vm_payg_2023_g2"
    },
    arm = {
      byol = "fortinet_fg-vm_arm64"
      payg = "fortinet_fg-vm_payg_2023_arm64"
    }
  }
}

variable "fgtversion" {
  type    = string
  default = "7.6.1"
}

variable "adminusername" {
  type    = string
  default = "cloudadmin"
}

variable "adminpassword" {
  type    = string
  default = "Fortinet.1234#"
}

variable "location" {
  type    = string
  default = "westeurope"
  //default = "westus2"
}

variable "vnetcidr" {
  default = "10.1.0.0/16"
}

variable "publiccidr" {
  default = "10.1.0.0/24"
}

variable "privatecidr" {
  default = "10.1.1.0/24"
}

variable "bootstrap-fgtvm" {
  // Change to your own path
  type    = string
  default = "fgtvm.conf"
}

// license file for the fgt
variable "license" {
  // Change to your own byol license file, license.lic
  type    = string
  default = "license.txt"
}

