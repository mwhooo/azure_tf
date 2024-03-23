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

variable "storage_name" {
  type = string
}

variable "tags" {
  type  = map(string)
  description = "Tags for Storage"
}
variable "public_access_enabled" {
  type = bool
  description = "If you want to enable public access or not"
}

variable "access_tier" {
  type = string
  description = "Access tier for the storage account"

}

