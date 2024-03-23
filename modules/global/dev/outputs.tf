# these global variables we will use in all tf deployments, so we dont need to repeat outself when changing values.
# not much options for any nested options though.
output "rg_name" {
  value = "azure-tf-demo"
}

output "windows_subnet" {
  value = "Windows_Subnet"
}

output "linux_subnet" {
  value = "Linux_Subnet"
}

output "vnet_name" {
  value = "demo-vnet"
}

output "storage_name" {
  value = "demostorage2411"
}

output "kv_name" {
  value = "demo-kv2411"
}

output "kv_sku" {
  value = "standard"
}

output "env_tag" {
  value = "demo"
}

output "address_space" {
  value = "10.0.0.0/16"
}

# locals {
#   # Common tags to be assigned to all resources
#   common_tags = {
#     env = "demo"
#     Owner   = "mark"
#   }
# }

# variable "address_space" {
#   type        = string
#   description = "Cidr range for the Virtual Network"
#   default     = "10.0.0.0/16"
# }
