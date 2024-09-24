variable "rg_name" {
  type = string
}

variable "windows_subnet_name" {
  type = string
}

variable "linux_subnet_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type        = string
  description = "Cidr range for the Virtual Network"
}

variable "subnet_bits" {
  description = "The number of additional bits for the subnet"
  type        = number
}

variable "windows_bits" {
  description = "The specific subnet number"
  type        = number
}

variable "linux_bits" {
  description = "The specific subnet number"
  type        = number
}

variable "storage_bits" {
  description = "The specific subnet number"
  type        = number
}

variable "storage_subnet_name" {
  description = "Name for the storagesubnet"
  type = string
}
