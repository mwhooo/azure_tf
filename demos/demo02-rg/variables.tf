variable "rg_name" {
  type        = string
  description = "RG Name"
}

variable "rg_location" {
  type        = string
  description = "Location of the resource group."
}

variable "tags" {
  type  = map(string)
  description = "Tags for RG"
}

variable "managed_by" {
  type = string
  description = "RG Managing person"
}
