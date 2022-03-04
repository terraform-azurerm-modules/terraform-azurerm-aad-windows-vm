variable "name" {
  description = "Hostname for the VM."
  type        = string
}

variable "subnet_id" {
  description = "Resource ID for a subnet."
  type        = string
}

variable "resource_group_name" {
  description = "Name for the resource group. Required."
  type        = string
}

//=============================================================

variable "size" {
  description = "Azure virtual machine size. Must support Gen 2."
  default     = "Standard_D2s_v3"
}

variable "location" {
  description = "Azure region."
  default     = "West Europe"
}

variable "tags" {
  description = "Map of tags for the resources created by this module."
  type        = map(string)
  default     = {}
}

//=============================================================

variable "admin_username" {
  description = "VM admin username."
  default     = "azureadmin"
}

variable "admin_password" {
  description = "Administrator password."
  type        = string
  sensitive   = true
}

variable "custom_data" {
  // This implementation of custom_data should keep CustomScriptExtension available
  description = "PowerShell script contents. Default installs Az PowerShell module."
  type        = string
  default     = null
}
