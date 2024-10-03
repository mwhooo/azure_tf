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

variable "general_bits" {
  description = "The specific subnet number"
  type        = number
}

variable "gateway_bits" {
  description = "The subnet number"
  type        = number
}
variable "general_subnet_name" {
  description = "Name for the general azure resource like, kv, storage, etc"
  type        = string
}

variable "gateway_subnet_name" {
  description = "Name for the subnet gateway, azure only accept 1 default name for the subnet"
  type        = string
}

variable "ports_windows" {
  type    = list(number)
  default = [443, 3389]
}