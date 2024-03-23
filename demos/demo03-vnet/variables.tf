variable "rg_name" {
  type = string
}

variable "windows_subnet" {
  type = string
}

variable "linux_subnet" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type        = string
  description = "Cidr range for the Virtual Network"
}


